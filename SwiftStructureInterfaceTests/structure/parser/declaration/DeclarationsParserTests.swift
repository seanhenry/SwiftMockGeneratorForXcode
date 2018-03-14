import XCTest
@testable import SwiftStructureInterface

class DeclarationsParserTests: XCTestCase {

    let newlineToNextDeclaration: Int64 = 3

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        let parser = FileParser(fileContents: "publi protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 6)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 18)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseProtocol() {
        let parser = FileParser(fileContents: getProtocolWithMethods())
        let file = parser.parse()
        let `protocol` = file.children[0] as! SwiftTypeElement
        XCTAssertEqual(`protocol`.text, getProtocolWithMethods())
        XCTAssertEqual(`protocol`.name, "MyProtocol")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, Int64(getProtocolWithMethods().utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, 21)
        let bodyLength: Int64 = calculateBodyLength(`protocol`)
        XCTAssertEqual(`protocol`.bodyLength, bodyLength)
        let bodyOffset = `protocol`.bodyOffset
        let associatedType = `protocol`.children[0]
        XCTAssertEqual(associatedType.text, getAssociatedType())
        XCTAssertEqual(associatedType.offset, bodyOffset + newlineToNextDeclaration)
        XCTAssertEqual(associatedType.length, Int64(getAssociatedType().utf8.count))
        let alias = `protocol`.children[1] as! Typealias
        XCTAssertEqual(alias.text, getTypealias())
        XCTAssertEqual(alias.offset, associatedType.offset + associatedType.length + newlineToNextDeclaration)
        XCTAssertEqual(alias.length, Int64(getTypealias().utf8.count))
        let initialiser = `protocol`.children[2] as! InitialiserDeclaration
        XCTAssertEqual(initialiser.text, getInitialiser())
        XCTAssertEqual(initialiser.offset, alias.offset + alias.length + newlineToNextDeclaration)
        XCTAssertEqual(initialiser.length, Int64(getInitialiser().utf8.count))
        let variable = `protocol`.children[3] as! VariableDeclaration
        XCTAssertEqual(variable.text, getVariable())
        XCTAssertEqual(variable.offset, initialiser.offset + initialiser.length + newlineToNextDeclaration)
        XCTAssertEqual(variable.length, Int64(getVariable().utf8.count))
        let function1 = `protocol`.children[4] as! FunctionDeclaration
        XCTAssertEqual(function1.text, getFunction())
        XCTAssertEqual(function1.offset, variable.offset + variable.length + newlineToNextDeclaration)
        XCTAssertEqual(function1.length, Int64(getFunction().utf8.count))
        let function2 = `protocol`.children[5] as! FunctionDeclaration
        XCTAssertEqual(function2.text, getFunction())
        XCTAssertEqual(function2.offset, function1.offset + function1.length + newlineToNextDeclaration)
        XCTAssertEqual(function2.length, Int64(getFunction().utf8.count))
    }

    // MARK: - Helpers

    func getProtocolWithMethods() -> String {
        return """
        protocol MyProtocol {
          \(getAssociatedType())
          \(getTypealias())
          \(getInitialiser())
          \(getVariable())
          \(getFunction())
          \(getFunction())
        }
        """
    }

    func getFunction() -> String {
        return """
        @a public mutating func aFunc(_ a: A, b c: D<E>) throws -> [String: Int]?
        """
    }

    func getAssociatedType() -> String {
        return """
        @a fileprivate associatedtype Name = A<T> where T.Type == String
        """
    }

    func getTypealias() -> String {
        return "@a open typealias Name<T, U, V: S> = Type<S>"
    }

    func getVariable() -> String {
        return "@a internal nonmutating var a: @a inout Generic<Type> { @a mutating set @b nonmutating get }"
    }

    func getInitialiser() -> String {
        return "@a public init?<T, U: V>(a: T, b: U.Type) throws where T.Type == U.Element"
    }

    private func calculateBodyLength(_ element: Element) -> Int64 {
        let newlineToClosingBrace: Int64 = 1
        return element.children.reduce(Int64(0)) { result, element in
            result + element.length + newlineToNextDeclaration
        } + newlineToClosingBrace
    }
}
