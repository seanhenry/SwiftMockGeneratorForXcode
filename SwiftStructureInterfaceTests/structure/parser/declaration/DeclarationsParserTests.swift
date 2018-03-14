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
        assertElementText(associatedType, getAssociatedType(), offset: bodyOffset + newlineToNextDeclaration)
        let alias = `protocol`.children[1] as! Typealias
        assertElementText(alias, getTypealias(), offset: associatedType.offset + associatedType.length + newlineToNextDeclaration)
        let initialiser = `protocol`.children[2] as! InitialiserDeclaration
        assertElementText(initialiser, getInitialiser(), offset: alias.offset + alias.length + newlineToNextDeclaration)
        let variable = `protocol`.children[3] as! VariableDeclaration
        assertElementText(variable, getVariable(), offset: initialiser.offset + initialiser.length + newlineToNextDeclaration)
        let function1 = `protocol`.children[4] as! FunctionDeclaration
        assertElementText(function1, getFunction(), offset: variable.offset + variable.length + newlineToNextDeclaration)
        let function2 = `protocol`.children[5] as! FunctionDeclaration
        assertElementText(function2, getFunction(), offset: function1.offset + function1.length + newlineToNextDeclaration)
        let subscriptDeclaration = `protocol`.children[6] as! SubscriptDeclaration
        assertElementText(subscriptDeclaration, getSubscript(), offset: function2.offset + function2.length + newlineToNextDeclaration)
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
          \(getSubscript())
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

    func getSubscript() -> String {
        return "@obj(SUB) public final subscript<T: U>(_ a: Int) -> @objc(NS) A where T.Type == U { @a nonmutating get @b mutating set }"
    }

    private func calculateBodyLength(_ element: Element) -> Int64 {
        let newlineToClosingBrace: Int64 = 1
        return element.children.reduce(Int64(0)) { result, element in
            result + element.length + newlineToNextDeclaration
        } + newlineToClosingBrace
    }
}
