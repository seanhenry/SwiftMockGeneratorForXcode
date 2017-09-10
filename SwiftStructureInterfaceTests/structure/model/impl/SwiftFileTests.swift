import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftFileTests: XCTestCase {

    var file: SwiftFile!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        file = emptySwiftFile
    }

    override func tearDown() {
        file = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - accept

    func test_accept_shouldSendItself() {
        file.accept(mockVisitor)
        XCTAssert(mockVisitor.invokedVisitSwiftFileParameters?.element === file)
        XCTAssert(mockVisitor.invokedVisitSwiftElementParameters?.element === file)
    }

    // MARK: - init

    func test_init_shouldAddItselfToAllChildren() {
        file = SKElementFactoryTestHelper.build(from: getNestedClassString())!
        XCTAssert(file.file === file)
        XCTAssert(file.children[0].file === file)
        let classB = file.children[0].children[0] as! SwiftTypeElement
        XCTAssert(classB.file === file)
        XCTAssert(classB.inheritedTypes[0].file === file)
        XCTAssert(classB.inheritedTypes[1].file === file)
        XCTAssert(classB.children[0].file === file)
        XCTAssert(file.children[0].children[1].file === file)
    }

    private func getNestedClassString() -> String {
        return "class A {" + "\n" +
            "    " + "\n" +
            "    class B: C, D {" + "\n" +
            "" + "\n" +
            "        func innerMethodA() {}" + "\n" +
            "    }" + "\n" +
            "" + "\n" +
            "    func methodA() {}" + "\n" +
            "}"
    }
}
