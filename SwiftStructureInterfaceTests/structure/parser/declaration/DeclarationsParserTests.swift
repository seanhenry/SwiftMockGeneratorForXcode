import XCTest
@testable import SwiftStructureInterface

class DeclarationsParserTests: XCTestCase {

    let newlineToNextDeclaration: Int64 = 3

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        let file = ElementParser.parseFile("publi protocol A {}")
        let `protocol` = file.typeDeclarations[0]
        XCTAssertEqual(`protocol`.text, "protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
    }

    func test_parse_shouldParseProtocol() {
        let file = ElementParser.parseFile(getProtocolWithMethods())
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

    func test_shouldParseSideBySideProtocols() {
        let file = ElementParser.parseFile(getMultipleProtocols())
        let protocolA = file.typeDeclarations[0]
        let funcA = protocolA.functionDeclarations[0]
        XCTAssertEqual(funcA.name, "a")
        let protocolB = file.typeDeclarations[1]
        let funcB = protocolB.functionDeclarations[0]
        XCTAssertEqual(funcB.name, "b")
    }

    func test_shouldSkipAllUnsupportedDeclarations() {
        let file = ElementParser.parseFile(getAll())
        StringCompareTestHelper.assertEqualStrings(file.text, getAll())
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

    func getAll() -> String {
        return """
        @testable import protocol TestProject.InnerProject
        @a public let const: Constant = 123
        @a open lazy var variable: Type = { return test }()
        @a open var variable2: Type = { 
            set {}
            get { return "abc" }
        }
        @a fileprivate typealias Type<T> = Generic<T>
        func test(_ a: A, b: [String: Int]) throws -> ReturnType where Some.Type == Element {
        let o = 0
        var a = 1
        func innerFunc() {
        }
        return something
        }
        enum A: B {
        case a, b
        case c(Int, String)
        
        func innerFunc() {}
        var computed: Int { return 0 }
        }
        
        struct Name: Prot {
        var i = 0
        func a() -> String { return "\\(i)" } 
        }
        
        class Test: A, B<C> where C.Type == String {
        class Inner: TestClass {}
        struct InnerStruct {}
        }
        
        extension P: A where A: B & C {}

        init?() { return nil }
        
        prefix operator ++: Group
        
        precedencegroup A {
        higherThan: A, B
        assignment: false
        associativity: left
        }
        
        protocol P {
        var a: A { get }
        }
        """
    }
}
