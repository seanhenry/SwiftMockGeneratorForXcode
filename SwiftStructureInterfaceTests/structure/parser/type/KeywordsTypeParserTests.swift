import XCTest
@testable import SwiftStructureInterface

class KeywordTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Keywords

    func test_parse_shouldParseAny() {
        assertTypeText("Any", "Any")
    }

    func test_parse_shouldParseSelf() {
        assertTypeText("Self", "Self")
    }

    // MARK: - Metatype

    func test_parse_shouldParseMetaTypes() {
        assertTypeText("MyType.Type", "MyType.Type")
        assertTypeText("MyType.Protocol", "MyType.Protocol")
    }

    // MARK: - Escaped

    func test_parse_shouldParseEscapedIdentifier() {
        assertTypeText("`Type`", "`Type`")
    }
}
