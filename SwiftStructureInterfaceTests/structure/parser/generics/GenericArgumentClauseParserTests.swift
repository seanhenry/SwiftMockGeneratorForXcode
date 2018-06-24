import XCTest
@testable import SwiftStructureInterface

class GenericArgumentClauseParserTests: XCTestCase {

    func test_shouldReturnEmptyClauseWhenNoOpeningBrace() {
        XCTAssert(parse("T>") === GenericArgumentClauseImpl.emptyGenericArgumentClause)
    }

    func test_shouldParseEmptyClause() {
        XCTAssertEqual(parse("<>").text, "<>")
    }

    func test_shouldParseSingleTypeClause() {
        let clause = parse("<T>")
        XCTAssertEqual(clause.text, "<T>")
        XCTAssertEqual(getTypes(clause).count, 1)
    }

    func test_shouldParseMultipleTypeClause() {
        let clause = parse("<T,U,V>")
        XCTAssertEqual(getTypes(clause).count, 3)
        XCTAssertEqual(clause.text, "<T,U,V>")
    }

    func test_shouldParseWhitespace() {
        XCTAssertEqual(parse("< T >").text, "< T >")
        XCTAssertEqual(parse("< T , U , V >").text, "< T , U , V >")
    }

    // MARK: - Helpers

    private func getTypes(_ clause: GenericArgumentClause) -> [Type] {
        return clause.children.compactMap { $0 as? Type }
    }

    func parse(_ input: String) -> GenericArgumentClause {
        return createParser(input, GenericArgumentClauseParser.self).parse()
    }
}
