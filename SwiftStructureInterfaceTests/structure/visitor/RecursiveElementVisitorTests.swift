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
        let classElement = getClass() as! SwiftElement
        let innerClass = classElement.children[0] as! SwiftElement
        let innerMethod = innerClass.children[0] as! SwiftElement
        let method = classElement.children[1] as! SwiftElement
        classElement.accept(visitor)
        XCTAssertEqual(getInvokedSwiftElementCount(), 4)
        XCTAssert(getInvokedSwiftElement(at: 0) === classElement)
        XCTAssert(getInvokedSwiftElement(at: 1) === innerClass)
        XCTAssert(getInvokedSwiftElement(at: 2) === innerMethod)
        XCTAssert(getInvokedSwiftElement(at: 3) === method)

        XCTAssertEqual(getInvokedSwiftTypeElementCount(), 2)
        XCTAssert(getInvokedSwiftTypeElement(at: 0) === classElement)
        XCTAssert(getInvokedSwiftTypeElement(at: 1) === innerClass)
    }

    // MARK: - Helpers

    private func getInvokedSwiftElement(at index: Int) -> SwiftElement {
        return mockInnerVisitor.invokedVisitSwiftElementParametersList[index].element as! SwiftElement
    }

    private func getInvokedSwiftTypeElement(at index: Int) -> SwiftTypeElement {
        return mockInnerVisitor.invokedVisitSwiftTypeElementParametersList[index].element as! SwiftTypeElement
    }

    private func getInvokedSwiftElementCount() -> Int {
        return mockInnerVisitor.invokedVisitSwiftElementParametersList.count
    }

    private func getInvokedSwiftTypeElementCount() -> Int {
        return mockInnerVisitor.invokedVisitSwiftTypeElementParametersList.count
    }

    private func getClass() -> Element {
        return StructureBuilder(data: Structure(file: File(contents: getNestedClassString())).dictionary).build()!
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
