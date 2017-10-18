import XCTest
@testable import SwiftStructureInterface

class FormatUtilTests: XCTestCase {

    var util: FormatUtil!

    override func setUp() {
        super.setUp()
        util = FormatUtil()
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
        let out = util.format(emptySwiftElement) as! SwiftElement
        XCTAssert(out === emptySwiftElement)
    }
    
    func test_format_shouldCorrectlyCountUTF16Character() {
        let file = SKElementFactoryTestHelper.build(from: getUTF16Class())!
        let outFile = util.format(file)
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedUTF16Class())
    }

    // MARK: - Helpers

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
