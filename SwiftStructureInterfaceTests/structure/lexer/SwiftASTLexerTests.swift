import XCTest
import Lexer
import Source
@testable import SwiftStructureInterface

class SwiftASTLexerTests: XCTestCase {

    func test_isNext_shouldReturnTrueWhenSingleOperator() {
        XCTAssert(createLexer("<").isNext("<"))
    }

    func test_isNext_shouldReturnFalseWhenNotMatchingOperator() {
        XCTAssertFalse(createLexer("!").isNext("<"))
    }

    func test_isNext_shouldReturnFalseWhenIdentifier() {
        XCTAssertFalse(createLexer("Type").isNext("<"))
    }

    func test_advanceOperator_shouldSplitStartGenericOperator() {
        let lexer = createLexer("<<")
        XCTAssert(lexer.isNext("<"))
        lexer.advanceOperator("<")
        XCTAssert(lexer.isNext("<"))
    }

    func test_advanceOperator_shouldSplitOptionalGeneric() {
        let lexer = createLexer(">?")
        XCTAssert(lexer.isNext(">"))
        lexer.advanceOperator(">")
        XCTAssert(lexer.isNext("?"))
    }

    func test_advanceOperator_shouldSplitOperatorAndAdvanceToNext() {
        let lexer = createLexer(">! test")
        XCTAssert(lexer.isNext(">"))
        lexer.advanceOperator(">")
        XCTAssert(lexer.isNext("!"))
        lexer.advanceOperator("!")
        XCTAssert(lexer.isNext(.identifier("test")))
    }
    
    // MARK: - Helpers
    
    func createLexer(_ text: String) -> SwiftASTLexer {
        return SwiftASTLexer(lexer: Lexer(source: SourceFile(content: text)))
    }
}
