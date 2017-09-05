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
        let inFile = StructureBuilderTestHelper.build(from: getExampleString())!
        let outFile = util.format(inFile)
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedString())
    }

    func test_format_shouldFormatSingleProperty() {
        let file = StructureBuilderTestHelper.build(from: getExampleString())!
        let outFile = util.format(file.children[0].children[0])
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedProperty())
    }

    func test_format_shouldFormatSingleMethod() {
        let file = StructureBuilderTestHelper.build(from: getExampleString())!
        let outFile = util.format(file.children[0].children[13])
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedMethod())
    }

    func test_format_shouldNotFormatElementWithoutFile() {
        let out = util.format(emptySwiftElement) as! SwiftElement
        XCTAssert(out === emptySwiftElement)
    }
    
    func test_format_shouldCorrectlyCountUTF16Character() {
        let file = StructureBuilderTestHelper.build(from: getUTF16Class())!
        let outFile = util.format(file)
        StringCompareTestHelper.assertEqualStrings(outFile.text, getFormattedUTF16Class())
    }

    // MARK: - Helpers

    private func getExampleString() -> String {
        return "class FormatExample {" + "\n" +
            "var invokedReadWriteSetter = false" + "\n" +
            "var invokedReadWriteSetterCount = 0" + "\n" +
            "var invokedReadWrite: String?" + "\n" +
            "var invokedReadWriteList = [String]()" + "\n" +
            "var invokedReadWriteGetter = false" + "\n" +
            "var invokedReadWriteGetterCount = 0" + "\n" +
            "var stubbedReadWrite: String! = \"\"" + "\n" +
            "var readWrite: String {" + "\n" +
            "set {" + "\n" +
            "invokedReadWriteSetter = true" + "\n" +
            "invokedReadWriteSetterCount += 1" + "\n" +
            "invokedReadWrite = newValue" + "\n" +
            "invokedReadWriteList.append(newValue)" + "\n" +
            "}" + "\n" +
            "get {" + "\n" +
            "invokedReadWriteGetter = true" + "\n" +
            "invokedReadWriteGetterCount += 1" + "\n" +
            "return stubbedReadWrite" + "\n" +
            "}" + "\n" +
            "}" + "\n" +
            "var invokedFilter = false" + "\n" +
            "var invokedFilterCount = 0" + "\n" +
            "var stubbedFilterClosureResult: (String, Void)?" + "\n" +
            "func filter(closure: (String) -> Bool) {" + "\n" +
            "invokedFilter = true" + "\n" +
            "invokedFilterCount += 1" + "\n" +
            "if let result = stubbedFilterClosureResult {" + "\n" +
            "_ = closure(result.0)" + "\n" +
            "}" + "\n" +
            "}" + "\n" +
            "}"
    }

    private func getFormattedString() -> String {
        return "class FormatExample {" + "\n" +
            "    var invokedReadWriteSetter = false" + "\n" +
            "    var invokedReadWriteSetterCount = 0" + "\n" +
            "    var invokedReadWrite: String?" + "\n" +
            "    var invokedReadWriteList = [String]()" + "\n" +
            "    var invokedReadWriteGetter = false" + "\n" +
            "    var invokedReadWriteGetterCount = 0" + "\n" +
            "    var stubbedReadWrite: String! = \"\"" + "\n" +
            "    var readWrite: String {" + "\n" +
            "        set {" + "\n" +
            "            invokedReadWriteSetter = true" + "\n" +
            "            invokedReadWriteSetterCount += 1" + "\n" +
            "            invokedReadWrite = newValue" + "\n" +
            "            invokedReadWriteList.append(newValue)" + "\n" +
            "        }" + "\n" +
            "        get {" + "\n" +
            "            invokedReadWriteGetter = true" + "\n" +
            "            invokedReadWriteGetterCount += 1" + "\n" +
            "            return stubbedReadWrite" + "\n" +
            "        }" + "\n" +
            "    }" + "\n" +
            "    var invokedFilter = false" + "\n" +
            "    var invokedFilterCount = 0" + "\n" +
            "    var stubbedFilterClosureResult: (String, Void)?" + "\n" +
            "    func filter(closure: (String) -> Bool) {" + "\n" +
            "        invokedFilter = true" + "\n" +
            "        invokedFilterCount += 1" + "\n" +
            "        if let result = stubbedFilterClosureResult {" + "\n" +
            "            _ = closure(result.0)" + "\n" +
            "        }" + "\n" +
            "    }" + "\n" +
            "}"
    }

    private func getFormattedProperty() -> String {
        return "class FormatExample {" + "\n" +
            "    var invokedReadWriteSetter = false" + "\n" +
            "var invokedReadWriteSetterCount = 0" + "\n" +
            "var invokedReadWrite: String?" + "\n" +
            "var invokedReadWriteList = [String]()" + "\n" +
            "var invokedReadWriteGetter = false" + "\n" +
            "var invokedReadWriteGetterCount = 0" + "\n" +
            "var stubbedReadWrite: String! = \"\"" + "\n" +
            "var readWrite: String {" + "\n" +
            "set {" + "\n" +
            "invokedReadWriteSetter = true" + "\n" +
            "invokedReadWriteSetterCount += 1" + "\n" +
            "invokedReadWrite = newValue" + "\n" +
            "invokedReadWriteList.append(newValue)" + "\n" +
            "}" + "\n" +
            "get {" + "\n" +
            "invokedReadWriteGetter = true" + "\n" +
            "invokedReadWriteGetterCount += 1" + "\n" +
            "return stubbedReadWrite" + "\n" +
            "}" + "\n" +
            "}" + "\n" +
            "var invokedFilter = false" + "\n" +
            "var invokedFilterCount = 0" + "\n" +
            "var stubbedFilterClosureResult: (String, Void)?" + "\n" +
            "func filter(closure: (String) -> Bool) {" + "\n" +
            "invokedFilter = true" + "\n" +
            "invokedFilterCount += 1" + "\n" +
            "if let result = stubbedFilterClosureResult {" + "\n" +
            "_ = closure(result.0)" + "\n" +
            "}" + "\n" +
            "}" + "\n" +
            "}"
    }

    private func getFormattedMethod() -> String {
        return "class FormatExample {" + "\n" +
            "var invokedReadWriteSetter = false" + "\n" +
            "var invokedReadWriteSetterCount = 0" + "\n" +
            "var invokedReadWrite: String?" + "\n" +
            "var invokedReadWriteList = [String]()" + "\n" +
            "var invokedReadWriteGetter = false" + "\n" +
            "var invokedReadWriteGetterCount = 0" + "\n" +
            "var stubbedReadWrite: String! = \"\"" + "\n" +
            "var readWrite: String {" + "\n" +
            "set {" + "\n" +
            "invokedReadWriteSetter = true" + "\n" +
            "invokedReadWriteSetterCount += 1" + "\n" +
            "invokedReadWrite = newValue" + "\n" +
            "invokedReadWriteList.append(newValue)" + "\n" +
            "}" + "\n" +
            "get {" + "\n" +
            "invokedReadWriteGetter = true" + "\n" +
            "invokedReadWriteGetterCount += 1" + "\n" +
            "return stubbedReadWrite" + "\n" +
            "}" + "\n" +
            "}" + "\n" +
            "var invokedFilter = false" + "\n" +
            "var invokedFilterCount = 0" + "\n" +
            "var stubbedFilterClosureResult: (String, Void)?" + "\n" +
            "    func filter(closure: (String) -> Bool) {" + "\n" +
            "        invokedFilter = true" + "\n" +
            "        invokedFilterCount += 1" + "\n" +
            "        if let result = stubbedFilterClosureResult {" + "\n" +
            "            _ = closure(result.0)" + "\n" +
            "        }" + "\n" +
            "    }" + "\n" +
            "}"
    }

    func getUTF16Class() -> String {
        // "✋️".utf8.count = 3
        // "💐".utf8.count = 4
        return "class 💐A {" + "\n" +
            "var var✋A = \"\"" + "\n" +
            "func method💐A() {}" + "\n" +
            "}"
    }

    func getFormattedUTF16Class() -> String {
        return "class 💐A {" + "\n" +
            "    var var✋A = \"\"" + "\n" +
            "    func method💐A() {}" + "\n" +
            "}"
    }
}
