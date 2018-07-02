import XCTest
@testable import SwiftStructureInterface

class PostfixExpressionParserTests: XCTestCase {

    private static let expressionsString = """
  expression
  "literal"
  [0, 1]
  ["test": 123]
  #line
  #imageLiteral(resourceName: "img")
  expression++
  self
  self.identifier
  self.init
  self[a: expression]
  super.identifier
  super.init
  super[a: expression]
  { [weak self] (argument: Int) in }
  (expression)
  (name: expression)
  .identifier
  _
  \\AType.identifier!
  #selector(expression)
  #keyPath(expression)

  functionCall(a: expression) { }
  expression.init(a:b:)
  expression.0
  expression.self
  expression[a:expression]
  expression!
  optChain?
  """

    static var expressions: [PostfixExpression]!

    override class func setUp() {
        super.setUp()
        let lines = expressionsString.components(separatedBy: "\n").filter { !$0.isEmpty }
        do {
            expressions = try lines.map { try createParser($0, PostfixExpressionParser.self).parse() }
        } catch {
            XCTFail("Failed to parse line")
        }
    }

    override class func tearDown() {
        expressions = nil
        super.tearDown()
    }

    func test_shouldParseExpressions() {
        let expressions = PostfixExpressionParserTests.expressions!
        XCTAssertEqual(expressions.count, 29)
        expressions.forEach { exp in
            exp.accept(Visitor())
        }
    }

    class Visitor: ElementVisitor {

        override func visitElement(_ element: Element) {
            XCTFail("No test for element \(element.text)")
        }

        override func visitArrayLiteralExpression(_ element: ArrayLiteralExpression) {
            XCTAssertEqual(element.text, "[0, 1]")
        }

        override func visitExplicitMemberExpression(_ element: ExplicitMemberExpression) {
            XCTAssertEqual(element.text, "expression.0")
        }

        override func visitForcedValueExpression(_ element: ForcedValueExpression) {
            XCTAssertEqual(element.text, "expression!")
        }

        override func visitFunctionCallExpression(_ element: FunctionCallExpression) {
            XCTAssertEqual(element.text, "functionCall(a: expression) { }")
        }

        override func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
            XCTAssertEqual(element.text, "expression")
        }

        override func visitImplicitMemberExpression(_ element: ImplicitMemberExpression) {
            XCTAssertEqual(element.text, ".identifier")
        }

        override func visitInitializerExpression(_ element: InitializerExpression) {
            XCTAssertEqual(element.text, "expression.init(a:b:)")
        }

        override func visitKeyPathExpression(_ element: KeyPathExpression) {
            XCTAssertEqual(element.text, "\\AType.identifier!")
        }

        override func visitKeyPathStringExpression(_ element: KeyPathStringExpression) {
            XCTAssertEqual(element.text, "#keyPath(expression)")
        }

        override func visitKeywordLiteralExpression(_ element: KeywordLiteralExpression) {
            XCTAssertEqual(element.text, "#line")
        }

        override func visitLiteralExpression(_ element: LiteralExpression) {
            XCTAssertEqual(element.text, "\"literal\"")
        }

        override func visitOperatorPostfixExpression(_ element: OperatorPostfixExpression) {
            XCTAssertEqual(element.text, "expression++")
        }

        override func visitOptionalChainingExpression(_ element: OptionalChainingExpression) {
            XCTAssertEqual(element.text, "optChain?")
        }

        override func visitParenthesizedExpression(_ element: ParenthesizedExpression) {
            XCTAssertEqual(element.text, "(expression)")
        }

        override func visitPlaygroundLiteralExpression(_ element: PlaygroundLiteralExpression) {
            XCTAssertEqual(element.text, "#imageLiteral(resourceName: \"img\")")
        }

        override func visitPostfixSelfExpression(_ element: PostfixSelfExpression) {
            XCTAssertEqual(element.text, "expression.self")
        }

        override func visitSelectorExpression(_ element: SelectorExpression) {
            XCTAssertEqual(element.text, "#selector(expression)")
        }

        override func visitSelfExpression(_ element: SelfExpression) {
            XCTAssertEqual(element.text, "self")
        }

        override func visitSelfInitializerExpression(_ element: SelfInitializerExpression) {
            XCTAssertEqual(element.text, "self.init")
        }

        override func visitSelfMethodExpression(_ element: SelfMethodExpression) {
            XCTAssertEqual(element.text, "self.identifier")
        }

        override func visitSelfSubscriptExpression(_ element: SelfSubscriptExpression) {
            XCTAssertEqual(element.text, "self[a: expression]")
        }

        override func visitSuperclassInitializerExpression(_ element: SuperclassInitializerExpression) {
            XCTAssertEqual(element.text, "super.init")
        }

        override func visitSuperclassMethodExpression(_ element: SuperclassMethodExpression) {
            XCTAssertEqual(element.text, "super.identifier")
        }

        override func visitSuperclassSubscriptExpression(_ element: SuperclassSubscriptExpression) {
            XCTAssertEqual(element.text, "super[a: expression]")
        }

        override func visitTupleExpression(_ element: TupleExpression) {
            XCTAssertEqual(element.text, "(name: expression)")
        }

        override func visitWildcardExpression(_ element: WildcardExpression) {
            XCTAssertEqual(element.text, "_")
        }

        override func visitDictionaryLiteralExpression(_ element: DictionaryLiteralExpression) {
            XCTAssertEqual(element.text, "[\"test\": 123]")
        }

        override func visitClosureExpression(_ element: ClosureExpression) {
            XCTAssertEqual(element.text, "{ [weak self] (argument: Int) in }")
        }

        override func visitSubscriptExpression(_ element: SubscriptExpression) {
            XCTAssertEqual(element.text, "expression[a:expression]")
        }
    }
}
