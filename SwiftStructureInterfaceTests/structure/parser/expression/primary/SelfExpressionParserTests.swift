import XCTest
@testable import SwiftStructureInterface

class SelfPrimaryExpressionParserTests: XCTestCase {

    func test_shouldParseSelfOnItsOwn() throws {
        let text = "self"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseSelfMethodExpression() throws {
        let text = "self.identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SelfMethodExpression)
    }

    func test_shouldParseSelfInitializerExpression() throws {
        let text = "self.init"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SelfInitializerExpression)
    }

    // TODO:
//    func test_shouldParseSelfSubscriptExpression() throws {
//        let text = "self[a: A, b: B]"
//        let expression = try parse(text)
//        XCTAssertEqual(expression.text, text)
//        XCTAssert(expression is SelfSubscriptExpression)
//    }

    private func parse(_ input: String) throws -> SelfExpression {
        return try createParser(input, SelfExpressionParser.self).parse()
    }
}
