import XCTest
@testable import SwiftStructureInterface

class DeclarationParserTests: XCTestCase {

    func test_parse_shouldParseProtocol() throws {
        let file = try ElementParser.parseFile(getProtocolWithMethods())
        let `protocol` = file.typeDeclarations[0]
        StringCompareTestHelper.assertEqualStrings(`protocol`.text, getProtocolWithMethods())
        XCTAssertEqual(`protocol`.name, "MyProtocol")
        let associatedType = `protocol`.associatedTypeDeclarations[0]
        assertElementText(associatedType, getAssociatedType())
        let alias = `protocol`.typealiasDeclarations[0]
        assertElementText(alias, getTypealias())
        let initializer = `protocol`.initializerDeclarations[0]
        assertElementText(initializer, getInitializer())
        let variable = `protocol`.variableDeclarations[0]
        assertElementText(variable, getVariable())
        let function1 = `protocol`.functionDeclarations[0]
        assertElementText(function1, getFunction())
        let function2 = `protocol`.functionDeclarations[1]
        assertElementText(function2, getFunction())
        let subscriptDeclaration = `protocol`.subscriptDeclarations[0]
        assertElementText(subscriptDeclaration, getSubscript())
    }

    func test_shouldParseSideBySideProtocols() throws {
        let file = try ElementParser.parseFile(getMultipleProtocols())
        let protocolA = file.typeDeclarations[0]
        let funcA = protocolA.functionDeclarations[0]
        XCTAssertEqual(funcA.name, "a")
        let protocolB = file.typeDeclarations[1]
        let funcB = protocolB.functionDeclarations[0]
        XCTAssertEqual(funcB.name, "b")
    }

    func test_shouldParseAClassDeclaration() throws {
        let file = try ParserTestHelper.parseFile(from: getClass())
        XCTAssert(file.typeDeclarations[0] is ClassDeclaration)
    }

    // MARK: - Helpers

    func getProtocolWithMethods() -> String {
        return """
        protocol MyProtocol {
          \(getAssociatedType())
          \(getTypealias())
          \(getInitializer())
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

    func getInitializer() -> String {
        return "@a public init?<T, U: V>(a: T, b: U.Type) throws where T.Type == U.Element"
    }

    func getSubscript() -> String {
        return "@obj(SUB) public final subscript<T: U>(_ a: Int) -> @objc(NS) A where T.Type == U { @a nonmutating get @b mutating set }"
    }

    private func calculateBodyLength(_ element: Element) -> Int64 {
        return Int64(getProtocolWithMethods().count - 22)
    }

    func getMultipleProtocols() -> String {
        return """
        protocol A {
        func a()
        }
        
        protocol B {
        func b()
        }
        """
    }

    func getClass() -> String {
        return """
        class MyClass {
        }
        """
    }
}
