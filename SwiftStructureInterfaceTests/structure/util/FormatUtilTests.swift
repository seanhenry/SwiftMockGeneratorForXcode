import XCTest
@testable import SwiftStructureInterface

class FormatUtilTests: XCTestCase {

    var util: FormatUtil!

    override func setUp() {
        super.setUp()
        FormatUtil.formatRequest = SKFormatRequest()
        util = FormatUtil(useTabs: false, spaces: 2)
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - format

    func test_format_shouldFormatClassesAndMethods_whenWholeFileIsProvided() {
        let inFile = SKElementFactoryTestHelper.build(from: getExampleString())!
        let outFile = util.format(inFile)
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedString())
    }

    func test_format_shouldFormatClassesAndMethods_whenSubElementIsProvided() {
        let file = SKElementFactoryTestHelper.build(from: getExampleString())!
        let outFile = util.format(file.children[0].children[0])
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedString())
    }

    func test_format_shouldNotFormatElementWithoutFile() {
        let out = util.format(emptyElement) as! ElementImpl
        XCTAssert(out === emptyElement)
    }
    
    func test_format_shouldCorrectlyCountUTF16Character() {
        let file = SKElementFactoryTestHelper.build(from: getUTF16Class())!
        let outFile = util.format(file)
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedUTF16Class())
    }

    func test_format_shouldReturnOriginalElement_whenFormattingFails() {
        FormatUtil.formatRequest = MockFormatRequest()
        let inFile = SKElementFactoryTestHelper.build(from: getExampleString())!
        let outFile = util.format(inFile)
        XCTAssert(outFile === inFile)
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
        let element = SKElementFactoryTestHelper.build(from: file)!.typeDeclarations[0]
        let formatted = util.format(inputLines, in: element)
        XCTAssertFalse(formatted.isEmpty)
        zip(formatted, expectedLines).forEach { XCTAssertEqual($0, $1, line: line) }
    }

    // MARK: - Helpers

    class MockFormatRequest: FormatRequest {
        class Error: Swift.Error {}
        func format(filePath: String) throws -> String {
            throw Error()
        }
    }

    private func getExampleString() -> String {
        return """
class FormatExample {
var invokedReadWriteSetter = false
var invokedReadWriteSetterCount = 0
var invokedReadWrite: String?
var invokedReadWriteList = [String]()
var invokedReadWriteGetter = false
var invokedReadWriteGetterCount = 0
var stubbedReadWrite: String! = \"\"
var readWrite: String {
set {
invokedReadWriteSetter = true
invokedReadWriteSetterCount += 1
invokedReadWrite = newValue
invokedReadWriteList.append(newValue)
}
get {
invokedReadWriteGetter = true
invokedReadWriteGetterCount += 1
return stubbedReadWrite
}
}
var invokedFilter = false
var invokedFilterCount = 0
var stubbedFilterClosureResult: (String, Void)?
func filter(closure: (String) -> Bool) {
invokedFilter = true
invokedFilterCount += 1
if let result = stubbedFilterClosureResult {
_ = closure(result.0)
}
}
}
"""
    }

    private func getFormattedString() -> String {
        return """
class FormatExample {
    var invokedReadWriteSetter = false
    var invokedReadWriteSetterCount = 0
    var invokedReadWrite: String?
    var invokedReadWriteList = [String]()
    var invokedReadWriteGetter = false
    var invokedReadWriteGetterCount = 0
    var stubbedReadWrite: String! = \"\"
    var readWrite: String {
        set {
            invokedReadWriteSetter = true
            invokedReadWriteSetterCount += 1
            invokedReadWrite = newValue
            invokedReadWriteList.append(newValue)
        }
        get {
            invokedReadWriteGetter = true
            invokedReadWriteGetterCount += 1
            return stubbedReadWrite
        }
    }
    var invokedFilter = false
    var invokedFilterCount = 0
    var stubbedFilterClosureResult: (String, Void)?
    func filter(closure: (String) -> Bool) {
        invokedFilter = true
        invokedFilterCount += 1
        if let result = stubbedFilterClosureResult {
            _ = closure(result.0)
        }
    }
}

"""
    }

    func getUTF16Class() -> String {
        // "✋️".utf8.count = 3
        // "💐".utf8.count = 4
        return """
class 💐A {
var var✋A = \"\"
func method💐A() {}
}
"""
    }

    func getFormattedUTF16Class() -> String {
        return """
class 💐A {
    var var✋A = \"\"
    func method💐A() {}
}

"""
    }
}
