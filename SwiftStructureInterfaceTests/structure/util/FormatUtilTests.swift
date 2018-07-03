import XCTest
@testable import SwiftStructureInterface

class FormatUtilTests: XCTestCase {

    var util: FormatUtil!

    override func setUp() {
        super.setUp()
        util = FormatUtil(useTabs: false, spaces: 2)
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - format(in:)

    func test_format_findAdd1LevelOfIndentWhenParentHasNoIndent() {
        let file = """
        class A {
        }
        """
        assertFormat("var a: A", "  var a: A", in: file)
    }

    func test_format_findIndentFromElementAndAddItToFormattedLines() {
        let file = """
             class A {
        }
        """
        assertFormat("var a: A", "       var a: A", in: file)
    }

    func test_format_shouldFormatLinesRelativeToParent() {
        let file = """
          class A {
          }
        """
        let input = """
        func a() {
        invokedA = true
        }
        """
        let expected = """
            func a() {
              invokedA = true
            }
        """
        assertFormat(input, expected, in: file)
    }

    func test_format_shouldIndentUsingTabs() {
        util = FormatUtil(useTabs: true, spaces: 2)
        let file = """
        \tclass A {
        }
        """
        assertFormat("var a: A", "\t\tvar a: A", in: file)
    }

    func test_format_shouldIndentUsingDifferentNumberOfSpaces() {
        util = FormatUtil(useTabs: false, spaces: 4)
        let file = """
            class A {
        }
        """
        assertFormat("var a: A", "        var a: A", in: file)
    }

    func test_format_shouldCopyElementIndentAndAddPreferredIndentOnTop() {
        util = FormatUtil(useTabs: false, spaces: 4)
        let file = """
        \t  \tclass A {
        }
        """
        assertFormat("var a: A", "\t  \t    var a: A", in: file)
    }

    private func assertFormat(_ input: String, _ expected: String, in file: String, line: UInt = #line) {
        let inputLines = input.components(separatedBy: "\n")
        let expectedLines = expected.components(separatedBy: "\n")
        do {
            let element = try ParserTestHelper.parseFile(from: file).typeDeclarations[0]
            let formatted = util.format(inputLines, relativeTo: element)
            XCTAssertFalse(formatted.isEmpty)
            zip(formatted, expectedLines).forEach { XCTAssertEqual($0, $1, line: line) }
        } catch {
            XCTFail("Failed to parse\n\(input)")
        }
    }
}
