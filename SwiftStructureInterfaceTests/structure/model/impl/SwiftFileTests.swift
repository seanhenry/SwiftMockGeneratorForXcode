import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftFileTests: XCTestCase {

    var file: SwiftFile!

    override func setUp() {
        super.setUp()
        file = emptyFile
    }

    override func tearDown() {
        file = nil
        super.tearDown()
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
        let methodA = classA.children[1] as! SwiftFunctionDeclaration
        let methodAParam = methodA.parameters[0]
        assertFilesAreEquivalent(methodA.file, file)
        assertFilesAreEquivalent(methodAParam.file, file)
        assertFilesAreEquivalent(methodAParam.typeAnnotation.type.file, file)
        assertFilesAreEquivalent(methodA.returnType?.file, file)
    }

    func test_init_copyingFileToChildren_shouldNotCauseRetaiwnCycle() {
        weak var weakFile: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getNestedClassString())
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
        XCTAssertNotNil(lhs, line: line)
        XCTAssertNotNil(rhs, line: line)
        guard let lhs = lhs, let rhs = rhs else { return }
        XCTAssertEqual(lhs.offset, rhs.offset, line: line)
        XCTAssertEqual(lhs.length, rhs.length, line: line)
        XCTAssertEqual(lhs.text, rhs.text, line: line)
        XCTAssertEqual(lhs.children.count, rhs.children.count, line: line)
        zip(lhs.children, rhs.children).forEach { XCTAssert($0 === $1, line: line) }
    }

    private func getNestedClassString() -> String {
        return """
class A {

    class B: C, D {

        func innerMethodA() {}
    }

    func methodA(a: A) -> T {}
}
"""
    }
}
