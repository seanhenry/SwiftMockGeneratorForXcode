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
        XCTAssert(lexer.isNext(.identifier("test", false)))
    }

    func test_advanceOperator_shouldPreserveCorrectPreviousLocation() {
        let lexer = createLexer("Int??")
        lexer.advance()
        XCTAssertEqual(lexer.getPreviousEndLocation().column, 3)
        XCTAssert(lexer.isNext("?"))
        lexer.advanceOperator("?")
        XCTAssertEqual(lexer.getPreviousEndLocation().column, 4)
        XCTAssert(lexer.isNext("?"))
        lexer.advanceOperator("?")
        XCTAssertEqual(lexer.getPreviousEndLocation().column, 5)
    }

    func test_advanceOperator_shouldNotAdvancePreviousLocationWhenOperatorDoesNotMatch() {
        let lexer = createLexer("Int??")
        lexer.advance()
        XCTAssertEqual(lexer.getPreviousEndLocation().column, 3)
        XCTAssert(lexer.isNext("?"))
        lexer.advanceOperator("!")
        XCTAssertEqual(lexer.getPreviousEndLocation().column, 3)
    }

    func test_checkPoint_shouldRememberTheLastRangeWhenRestored() {
        let lexer = createLexer("private(set)")
        lexer.advance()
        let lastRange = lexer.lastRange
        let id = lexer.setCheckPoint()
        lexer.advance()
        lexer.advance()
        lexer.restoreCheckPoint(id)
        XCTAssertEqual(lastRange.start.column, lexer.lastRange.start.column)
        XCTAssertEqual(lastRange.start.line, lexer.lastRange.start.line)
        XCTAssertEqual(lastRange.end.column, lexer.lastRange.end.column)
        XCTAssertEqual(lastRange.end.line, lexer.lastRange.end.line)
    }

    func test_peekAtKindAheadBy_shouldShowNextForN() {
        let lexer = createLexer(": , ;")
        XCTAssertEqual(lexer.peekAtKind(aheadBy: 0), .colon)
        XCTAssertEqual(lexer.peekAtKind(aheadBy: 1), .comma)
        XCTAssertEqual(lexer.peekAtKind(aheadBy: 2), .semicolon)
    }

    // MARK: - Helpers
    
    func createLexer(_ text: String) -> SwiftASTLexer {
        return SwiftASTLexer(lexer: Lexer(source: SourceFile(content: text)))
    }
}
