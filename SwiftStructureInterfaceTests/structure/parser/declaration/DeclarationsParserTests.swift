import XCTest
@testable import SwiftStructureInterface

class DeclarationsParserTests: XCTestCase {

    let newlineToNextDeclaration: Int64 = 3

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        let parser = FileParser(fileContents: "publi protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeDeclaration
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
        let `protocol` = file.children[0] as! SwiftTypeDeclaration
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

    func test_shouldParseSideBySideProtocols() {
        let file = FileParser(fileContents: getMultipleProtocols()).parse()
        let protocolA = file.children[0] as! TypeDeclaration
        XCTAssertEqual(protocolA.children.count, 1)
        let funcA = protocolA.children[0] as! FunctionDeclaration
        XCTAssertEqual(funcA.name, "a")
        let protocolB = file.children[1] as! TypeDeclaration
        XCTAssertEqual(protocolB.children.count, 1)
        let funcB = protocolB.children[0] as! FunctionDeclaration
        XCTAssertEqual(funcB.name, "b")
    }

    func test_shouldSkipAllUnsupportedDeclarations() {
        let protocolStart = getAll().range(of: "protocol P {")!.lowerBound
        let offset = Int64(protocolStart.encodedOffset)
        let file = FileParser(fileContents: getAll()).parse()
        XCTAssert(file.children.last is SwiftTypeDeclaration, String(describing: file.children.last))
        XCTAssertEqual(file.children.last?.children.count, 1)
        XCTAssertEqual(file.children.last?.offset, offset)
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
