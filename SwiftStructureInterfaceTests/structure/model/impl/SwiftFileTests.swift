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

    func test_init_shouldAddCopyOfItselfToAllChildren() {
        file = SKElementFactoryTestHelper.build(from: getNestedClassString())!
        assertFilesAreEquivalent(file.file, file)
        let classA = file.children[0]
        assertFilesAreEquivalent(classA.file, file)
        let classB = classA.children[0] as! SwiftTypeElement
        assertFilesAreEquivalent(classB.file, file)
        assertFilesAreEquivalent(classB.inheritedTypes[0].file, file)
        assertFilesAreEquivalent(classB.inheritedTypes[1].file, file)
        assertFilesAreEquivalent(classB.children[0].file, file)
        let methodA = classA.children[1] as! SwiftMethodElement
        let methodAParam = methodA.parameters[0]
        assertFilesAreEquivalent(methodA.file, file)
        assertFilesAreEquivalent(methodAParam.file, file)
        assertFilesAreEquivalent(methodAParam.type.file, file)
    }

    func test_init_copyingFileToChildren_shouldNotCauseRetainCycle() {
        weak var weakFile: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getNestedClassString())!
            weakFile = file
        }
        XCTAssertNil(weakFile)
    }

    func test_fileShouldBePresent_whenProgramHoldsAReferenceToAChild() {
        var child: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getNestedClassString())!
            child = file.children[0]
        }
        XCTAssertNotNil(child?.file)
    }

    func test_copyOfFile_shouldKeepStrongReferencesToChildren() {
        var fileCopy: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getNestedClassString())!
            fileCopy = file.children[0].file
        }
        XCTAssertEqual(fileCopy?.children.count, 1)
    }

    private func assertFilesAreEquivalent(_ lhs: Element?, _ rhs: Element?, line: UInt = #line) {
        XCTAssertNotNil(lhs)
        XCTAssertNotNil(rhs)
        guard let lhs = lhs, let rhs = rhs else { return }
        XCTAssertEqual(lhs.offset, rhs.offset)
        XCTAssertEqual(lhs.length, rhs.length)
        XCTAssertEqual(lhs.text, rhs.text)
        XCTAssertEqual(lhs.children.count, rhs.children.count)
        zip(lhs.children, rhs.children).forEach { XCTAssert($0 === $1) }
    }

    private func getNestedClassString() -> String {
        return """
class A {

    class B: C, D {

        func innerMethodA() {}
    }

    func methodA(a: A) {}
}
"""
    }
}
