import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class RecursiveElementVisitorTests: XCTestCase {

    var visitor: RecursiveElementVisitor!
    var mockInnerVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockInnerVisitor = MockElementVisitor()
        visitor = RecursiveElementVisitor(visitor: mockInnerVisitor)
    }

    override func tearDown() {
        visitor = nil
        mockInnerVisitor = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldRecursivelyForwardToInnerVisitor() {
        let file = getClassFile() as! SwiftFile
        let classElement = file.children[0] as! SwiftElement
        let innerClass = classElement.children[0] as! SwiftElement
        let innerMethod = innerClass.children[0] as! SwiftElement
        let method = classElement.children[1] as! SwiftElement
        file.accept(visitor)
        XCTAssertEqual(getInvokedSwiftElementCount(), 5)
        XCTAssert(getInvokedSwiftElement(at: 0) === file)
        XCTAssert(getInvokedSwiftElement(at: 1) === classElement)
        XCTAssert(getInvokedSwiftElement(at: 2) === innerClass)
        XCTAssert(getInvokedSwiftElement(at: 3) === innerMethod)
        XCTAssert(getInvokedSwiftElement(at: 4) === method)

        XCTAssertEqual(getInvokedSwiftTypeElementCount(), 2)
        XCTAssert(getInvokedSwiftTypeElement(at: 0) === classElement)
        XCTAssert(getInvokedSwiftTypeElement(at: 1) === innerClass)

        XCTAssertEqual(getInvokedSwiftFileCount(), 1)
        XCTAssert(getInvokedSwiftFile(at: 0) === file)
    }

    // MARK: - Helpers

    private func getInvokedSwiftElement(at index: Int) -> SwiftElement {
        return mockInnerVisitor.invokedVisitSwiftElementParametersList[index].element
    }

    private func getInvokedSwiftTypeElement(at index: Int) -> SwiftTypeElement {
        return mockInnerVisitor.invokedVisitSwiftTypeElementParametersList[index].element
    }

    private func getInvokedSwiftFile(at index: Int) -> SwiftFile {
        return mockInnerVisitor.invokedVisitSwiftFileParametersList[index].element
    }

    private func getInvokedSwiftElementCount() -> Int {
        return mockInnerVisitor.invokedVisitSwiftElementParametersList.count
    }

    private func getInvokedSwiftTypeElementCount() -> Int {
        return mockInnerVisitor.invokedVisitSwiftTypeElementParametersList.count
    }

    private func getInvokedSwiftFileCount() -> Int {
        return mockInnerVisitor.invokedVisitSwiftFileParametersList.count
    }

    private func getClassFile() -> Element {
        let string = getNestedClassString()
        return StructureBuilder(data: Structure(file: File(contents: string)).dictionary, text: string).build()
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
