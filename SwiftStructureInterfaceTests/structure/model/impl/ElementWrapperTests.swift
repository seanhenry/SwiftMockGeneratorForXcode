import XCTest
@testable import SwiftStructureInterface

class ElementWrapperTest: XCTestCase {

    func test_shouldManageLifecycleOfFile() {
        weak var weakFile: File?
        autoreleasepool {
            let fileWrapper = createFile()
            let file = fileWrapper.managed as! FileImpl
            XCTAssertGreaterThan(file.retainCount, 0)
            weakFile = file
        }
        XCTAssertNil(weakFile)
    }

    func test_shouldManageLifecycleOfFileWhenHoldingChild() {
        weak var weakFile: File?
        weak var weakChild: Element?
        autoreleasepool {
            let fileWrapper = createFile()
            let file = fileWrapper.managed as! FileImpl
            let child = fileWrapper.children[0]
            XCTAssertGreaterThan(file.retainCount, 0)
            weakChild = child
            weakFile = file
        }
        XCTAssertNil(weakFile)
        XCTAssertNil(weakChild)
    }

    func test_shouldManageLifecycleOfFileWhenHoldingGrandchild() {
        weak var weakFile: File?
        weak var weakGrandchild: Element?
        autoreleasepool {
            let fileWrapper = createFile()
            let file = fileWrapper.managed as! FileImpl
            let grandchild = fileWrapper.children[0].children[0]
            XCTAssertGreaterThan(file.retainCount, 0)
            weakGrandchild = grandchild
            weakFile = file
        }
        XCTAssertNil(weakFile)
        XCTAssertNil(weakGrandchild)
    }

    func test_shouldKeepStructureAliveWhenAtLeastOneReference() {
        weak var weakFile: File?
        weak var weakChild: Element?
        var strongGrandchild: Element?
        autoreleasepool {
            let fileWrapper = createFile()
            let file = fileWrapper.managed as! FileImpl
            strongGrandchild = fileWrapper.children[0].children[0]
            XCTAssertGreaterThan(file.retainCount, 0)
            weakFile = file
            weakChild = file.children[0]
        }
        XCTAssertNotNil(weakFile)
        XCTAssertNotNil(weakChild)
        XCTAssertNotNil(weakChild?.file)
        XCTAssertNotNil(strongGrandchild)
    }

    func test_shouldWrapElement() {
        let file = createFile()
        let child = file.children[0]
        let rawFile = file.managed as! FileImpl
        let rawChild = rawFile.children[0]
        XCTAssertEqual(rawChild.children.count, child.children.count)
        XCTAssertEqual(rawChild.offset, child.offset)
        XCTAssertEqual(rawChild.length, child.length)
        XCTAssertEqual(rawChild.text, child.text)
    }

    private func wrap(_ element: Element) -> ElementWrapper? {
        return ElementWrapper(element as! ElementImpl)
    }

    private func suppressWarning(_ wrapper: Element?) {
    }

    private func createFile() -> SwiftStructureInterface.FileWrapper {
        return ElementParser.parseFile("protocol A { var a: A { get } }") as! SwiftStructureInterface.FileWrapper
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
