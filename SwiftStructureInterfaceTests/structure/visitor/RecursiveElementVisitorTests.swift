import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class RecursiveElementVisitorTests: XCTestCase {

    var mockVisitor: MockRecursiveVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockRecursiveVisitor()
    }

    override func tearDown() {
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldRecursivelyForwardToInnerVisitor() {
        let file = getClassFile() as! SwiftFile
        let classElement = file.namedChildren[0]
        let innerClass = classElement.namedChildren[0]
        let innerMethod = innerClass.namedChildren[0]
        let innerProperty = innerClass.namedChildren[1]
        let method = classElement.namedChildren[1]
        let property = classElement.namedChildren[2]
        file.accept(mockVisitor)
        XCTAssertEqual(getInvokedSwiftElementCount(), 9)
        XCTAssert(getInvokedSwiftElement(at: 0) === file)
        XCTAssert(getInvokedSwiftElement(at: 1) === classElement)
        XCTAssert(getInvokedSwiftElement(at: 2) === innerClass)
        XCTAssert(getInvokedSwiftElement(at: 5) === innerMethod)
        XCTAssert(getInvokedSwiftElement(at: 6) === innerProperty)
        XCTAssert(getInvokedSwiftElement(at: 7) === method)
        XCTAssert(getInvokedSwiftElement(at: 8) === property)

        XCTAssertEqual(getInvokedSwiftTypeElementCount(), 2)
        XCTAssert(getInvokedSwiftTypeElement(at: 0) === classElement)
        XCTAssert(getInvokedSwiftTypeElement(at: 1) === innerClass)

        XCTAssertEqual(getInvokedSwiftFileCount(), 1)
        XCTAssert(getInvokedSwiftFile(at: 0) === file)

        XCTAssertEqual(getInvokedSwiftMethodElementCount(), 2)
        XCTAssert(getInvokedSwiftMethodElement(at: 0) === innerMethod)
        XCTAssert(getInvokedSwiftMethodElement(at: 1) === method)

        XCTAssertEqual(getInvokedSwiftPropertyElementCount(), 2)
        XCTAssert(getInvokedSwiftPropertyElement(at: 0) === innerProperty)
        XCTAssert(getInvokedSwiftPropertyElement(at: 1) === property)
    }

    // MARK: - Helpers

    private func getInvokedSwiftElement(at index: Int) -> Element {
        return mockVisitor.invokedVisitElementParametersList[index].element
    }

    private func getInvokedSwiftTypeElement(at index: Int) -> TypeDeclaration {
        return mockVisitor.invokedVisitTypeDeclarationParametersList[index].element
    }

    private func getInvokedSwiftFile(at index: Int) -> SwiftStructureInterface.File {
        return mockVisitor.invokedVisitFileParametersList[index].element
    }

    private func getInvokedSwiftMethodElement(at index: Int) -> FunctionDeclaration {
        return mockVisitor.invokedVisitFunctionDeclarationParametersList[index].element
    }

    private func getInvokedSwiftPropertyElement(at index: Int) -> VariableDeclaration {
        return mockVisitor.invokedVisitVariableDeclarationParametersList[index].element
    }

    private func getInvokedSwiftElementCount() -> Int {
        return mockVisitor.invokedVisitElementCount
    }

    private func getInvokedSwiftTypeElementCount() -> Int {
        return mockVisitor.invokedVisitTypeDeclarationCount
    }

    private func getInvokedSwiftFileCount() -> Int {
        return mockVisitor.invokedVisitFileCount
    }

    private func getInvokedSwiftMethodElementCount() -> Int {
        return mockVisitor.invokedVisitFunctionDeclarationCount
    }

    private func getInvokedSwiftPropertyElementCount() -> Int {
        return mockVisitor.invokedVisitVariableDeclarationCount
    }

    private func getClassFile() -> Element {
        return SKElementFactoryTestHelper.build(from: getNestedClassString())!
    }

    private func getNestedClassString() -> String {
        return """
class A {

    class B: C, D {

        func innerMethodA() {}
        var propertyB = 0
    }

    func methodA() {}
    var propertyA: Int?
}
"""
    }
}
