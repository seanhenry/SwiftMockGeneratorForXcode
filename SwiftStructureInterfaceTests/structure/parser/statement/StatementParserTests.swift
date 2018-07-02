import XCTest
@testable import SwiftStructureInterface

class StatementParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "self.init(a: function())"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseDeclaration() throws {
        let text = "func test(a: A)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseEverythingInAFile() throws {
        let file = try ParserTestHelper.parseFile(from: getAll())
        StringCompareTestHelper.assertEqualStrings(file.text, getAll())
    }

    func test_parse_shouldParseDeclarationWithMisspelledAccessModifier() throws {
        let file = try ElementParser.parseFile("publi protocol A {}")
        let `protocol` = file.typeDeclarations[0]
        XCTAssertEqual(`protocol`.text, "protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
    }

    private func parse(_ input: String) throws -> Statement {
        return try createParser(input, StatementParser.self).parse()
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
