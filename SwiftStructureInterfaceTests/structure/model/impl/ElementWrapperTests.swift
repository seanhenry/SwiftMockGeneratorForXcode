import XCTest
@testable import SwiftStructureInterface

class ElementWrapperTest: XCTestCase {

    func test_shouldManageLifecycleOfFile() {
        weak var weakFile: File?
        autoreleasepool {
            let file = createFile()
            let wrapper: ElementWrapper? = ElementWrapper(file)
            suppressWarning(wrapper)
            XCTAssertEqual(file.retainCount, 1)
            weakFile = file
        }
        XCTAssertNil(weakFile)
    }

    func test_shouldManageLifecycleOfFileWhenHoldingChild() {
        weak var weakFile: File?
        weak var weakChild: Element?
        autoreleasepool {
            let file = createFile()
            let wrapper: ElementWrapper? = ElementWrapper(file.children[0])
            suppressWarning(wrapper)
            XCTAssertEqual(file.retainCount, 1)
            weakChild = file.children[0]
            weakFile = file
        }
        XCTAssertNil(weakFile)
        XCTAssertNil(weakChild)
    }

    func test_shouldManageLifecycleOfFileWhenHoldingGrandchild() {
        weak var weakFile: File?
        weak var weakGrandchild: Element?
        autoreleasepool {
            let file = createFile()
            let wrapper: ElementWrapper? = ElementWrapper(file.children[0].children[0])
            suppressWarning(wrapper)
            XCTAssertEqual(file.retainCount, 1)
            weakGrandchild = file.children[0].children[0]
            weakFile = file
        }
        XCTAssertNil(weakFile)
        XCTAssertNil(weakGrandchild)
    }

    func test_shouldKeepStructureAliveWhenAtLeastOneReference() {
        weak var weakFile: File?
        weak var weakChild: Element?
        var strongWrapper: ElementWrapper?
        autoreleasepool {
            let file = createFile()
            let wrapper: ElementWrapper? = ElementWrapper(file.children[0].children[0])
            suppressWarning(wrapper)
            strongWrapper = ElementWrapper(file.children[0].children[0])
            XCTAssertEqual(file.retainCount, 2)
            weakFile = file
            weakChild = file.children[0]
        }
        XCTAssertNotNil(weakFile)
        XCTAssertNotNil(weakChild)
        XCTAssertNotNil(weakChild?.file)
    }

    func test_shouldWrapElement() {
        let element = createFile().children[0]
        let wrapper = ElementWrapper(element)
        XCTAssertEqual(wrapper.children.count, element.children.count)
        XCTAssert(wrapper.children[0] === element.children[0])
        XCTAssert(wrapper.file === element.file)
        XCTAssert(wrapper.parent === element.parent)
        XCTAssertEqual(wrapper.offset, element.offset)
        XCTAssertEqual(wrapper.length, element.length)
        XCTAssertEqual(wrapper.text, element.text)
    }

    func test_shouldAcceptOnBehalfOfManagedElement() {
        let visitorSpy = VisitorSpy()
        let element = createFile().children[0]
        let wrapper = ElementWrapper(element)
        wrapper.accept(visitorSpy)
        XCTAssert(visitorSpy.invokedVisitTypeDeclaration)
        XCTAssert(visitorSpy.invokedVisitElement)
    }

    private func suppressWarning(_ wrapper: ElementWrapper?) {
    }

    private func createFile() -> SwiftFile {
        return ElementParser.parseFile("protocol A { var a: A { get } }") as! SwiftFile
    }

    private class VisitorSpy: ElementVisitor {

        var invokedVisitElement = false
        override func visitElement(_ element: Element) {
            invokedVisitElement = true
            super.visitElement(element)
        }

        var invokedVisitTypeDeclaration = false
        override func visitTypeDeclaration(_ element: TypeDeclaration) {
            invokedVisitTypeDeclaration = true
            super.visitTypeDeclaration(element)
        }
    }
}
