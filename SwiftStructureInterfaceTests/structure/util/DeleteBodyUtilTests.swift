import XCTest
@testable import SwiftStructureInterface

class DeleteBodyUtilTests: XCTestCase {

    var util: DeleteBodyUtil!

    override func setUp() {
        super.setUp()
        util = DeleteBodyUtil()
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - deleteClassBody

    func test_deleteClassBody_shouldReturnElementWithBodyRemoved() {
        let file = SKElementFactoryTestHelper.build(from: getSimpleClass())!
        let classElement = file.children[0]
        let result = util.deleteClassBody(from: classElement)!
        StringCompareTestHelper.assertEqualStrings(result.file.text, getExpectedSimpleClass())
        StringCompareTestHelper.assertEqualStrings(result.element.text, getExpectedSimpleClass())
    }

    func test_deleteClassBody_shouldReturnClassElement() {
        let file = SKElementFactoryTestHelper.build(from: getSimpleClass())!
        let classElement = file.children[0]
        let result = util.deleteClassBody(from: classElement)!
        XCTAssert(result.element is SwiftTypeDeclaration)
    }

    func test_deleteClassBody_returnsNil_whenElementHasNoFile() {
        XCTAssertNil(util.deleteClassBody(from: emptyTypeDeclaration))
    }

    func test_deleteClassBody_returnsNil_whenClassElementHasBadOffsets() {
        let element = SwiftTypeDeclaration(name: "A", text: "class A { }", children: [], inheritedTypes: [], offset: -1, length: 0, bodyOffset: 100, bodyLength: 0, accessLevelModifier: SwiftAccessLevelModifier.emptyAccessLevelModifier)
        let file = SwiftFile(text: "class A { }", children: [element], offset: 0, length: 11)
        XCTAssertNil(util.deleteClassBody(from: file.children[0]))
    }

    func test_deleteClassBody_shouldDeleteUTF16Contents() {
        let file = SKElementFactoryTestHelper.build(from: getUTF16Class())!
        let classElement = file.children[0]
        let result = util.deleteClassBody(from: classElement)!
        StringCompareTestHelper.assertEqualStrings(result.file.text, getExpectedUTF16Class())
        StringCompareTestHelper.assertEqualStrings(result.element.text, getExpectedUTF16Class())
    }

    // MARK: - Helpers

    func getSimpleClass() -> String {
        return """
class A {
  var varA = \"\"
}
"""
    }

    func getExpectedSimpleClass() -> String {
        return """
class A {
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

    func getExpectedUTF16Class() -> String {
        return """
class 💐A {
}
"""
    }
}
