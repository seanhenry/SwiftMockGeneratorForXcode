import XCTest
@testable import SwiftStructureInterface

class ElementVisitorTests: XCTestCase {

    var visitor: PartialMockVisitor!

    override func setUp() {
        super.setUp()
        visitor = PartialMockVisitor()
    }

    override func tearDown() {
        visitor = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit() {
        // TODO: generate me?
//        XCTAssertEqual(allTestElements.count, 24)
        // Elements
        assertVisitorIsImplemented(testFile) { $0.invokedVisitFile }
        assertVisitorIsImplemented(testElement) { $0.invokedVisitElement }
        assertVisitorIsImplemented(testTypeDeclaration) { $0.invokedVisitTypeDeclaration }
        assertVisitorIsImplemented(testAccessLevelModifier) { $0.invokedVisitAccessLevelModifier }
        assertVisitorIsImplemented(testInitializerDeclaration) { $0.invokedVisitInitializerDeclaration }
        assertVisitorIsImplemented(testVariableDeclaration) { $0.invokedVisitVariableDeclaration }
        assertVisitorIsImplemented(testParameter) { $0.invokedVisitParameter }
        assertVisitorIsImplemented(testGenericParameterClause) { $0.invokedVisitGenericParameterClause }
        assertVisitorIsImplemented(testGenericParameter) { $0.invokedVisitGenericParameter }
        assertVisitorIsImplemented(testSubscriptDeclaration) { $0.invokedVisitSubscriptDeclaration }
        assertVisitorIsImplemented(testTypealiasDeclaration) { $0.invokedVisitTypealiasDeclaration }
        assertVisitorIsImplemented(testTypealiasAssignment) { $0.invokedVisitTypealiasAssignment }
        assertVisitorIsImplemented(testTypeAnnotation) { $0.invokedVisitTypeAnnotation }
        assertVisitorIsImplemented(testTupleTypeElement) { $0.invokedVisitTupleTypeElement }
        assertVisitorIsImplemented(testFunctionDeclaration) { $0.invokedVisitFunctionDeclaration }
        assertVisitorIsImplemented(testGetterSetterKeywordBlock) { $0.invokedVisitGetterSetterKeywordBlock }
        // Types
        assertVisitorIsImplemented(testType) { $0.invokedVisitType }
        assertVisitorIsImplementedByType(testTypeIdentifier) { $0.invokedVisitTypeIdentifier }
        assertVisitorIsImplementedByType(testTupleType) { $0.invokedVisitTupleType }
        assertVisitorIsImplementedByType(testArrayType) { $0.invokedVisitArrayType }
        assertVisitorIsImplementedByType(testDictionaryType) { $0.invokedVisitDictionaryType }
        assertVisitorIsImplementedByType(testOptionalType) { $0.invokedVisitOptionalType }
        assertVisitorIsImplementedByType(testFunctionType) { $0.invokedVisitFunctionType }
        assertVisitorIsImplementedByType(testProtocolCompositionType) { $0.invokedVisitProtocolCompositionType }
    }

    private func assertVisitorIsImplemented(_ element: Element, line: UInt = #line, _ isInvoked: (PartialMockVisitor) -> Bool) {
        let visitor = PartialMockVisitor()
        element.accept(visitor)
        XCTAssertTrue(isInvoked(visitor), line: line)
        XCTAssertTrue(visitor.invokedVisitElement, "All elements should visit the Element protocol", line: line)
    }

    private func assertVisitorIsImplementedByType(_ element: Type, line: UInt = #line, _ isInvoked: (PartialMockVisitor) -> Bool) {
        let visitor = PartialMockVisitor()
        element.accept(visitor)
        XCTAssertTrue(isInvoked(visitor), line: line)
        XCTAssertTrue(visitor.invokedVisitType, "All types should visit the Type protocol", line: line)
        XCTAssertTrue(visitor.invokedVisitElement, "All elements should visit the Element protocol", line: line)
    }

    // MARK: - Helpers

    class PartialMockVisitor: ElementVisitor {

        var invokedVisitElement = false

        override func visitElement(_ element: Element) {
            super.visitElement(element)
            invokedVisitElement = true
        }

        var invokedVisitTypeDeclaration = false

        override func visitTypeDeclaration(_ element: TypeDeclaration) {
            super.visitTypeDeclaration(element)
            invokedVisitTypeDeclaration = true
        }

        var invokedVisitFile = false

        override func visitFile(_ element: File) {
            super.visitFile(element)
            invokedVisitFile = true
        }

        var invokedVisitFunctionDeclaration = false

        override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
            super.visitFunctionDeclaration(element)
            invokedVisitFunctionDeclaration = true
        }

        var invokedVisitVariableDeclaration = false

        override func visitVariableDeclaration(_ element: VariableDeclaration) {
            super.visitVariableDeclaration(element)
            invokedVisitVariableDeclaration = true
        }

        var invokedVisitGenericParameterClause = false

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            super.visitGenericParameterClause(element)
            invokedVisitGenericParameterClause = true
        }

        var invokedVisitGenericParameter = false

        override func visitGenericParameter(_ element: GenericParameter) {
            super.visitGenericParameter(element)
            invokedVisitGenericParameter = true
        }

        var invokedVisitType = false

        override func visitType(_ element: Type) {
            super.visitType(element)
            invokedVisitType = true
        }

        var invokedVisitArrayType = false

        override func visitArrayType(_ element: ArrayType) {
            super.visitArrayType(element)
            invokedVisitArrayType = true
        }

        var invokedVisitDictionaryType = false

        override func visitDictionaryType(_ element: DictionaryType) {
            super.visitDictionaryType(element)
            invokedVisitDictionaryType = true
        }

        var invokedVisitOptionalType = false

        override func visitOptionalType(_ element: OptionalType) {
            super.visitOptionalType(element)
            invokedVisitOptionalType = true
        }

        var invokedVisitTypeIdentifier = false

        override func visitTypeIdentifier(_ element: TypeIdentifier) {
            super.visitTypeIdentifier(element)
            invokedVisitTypeIdentifier = true
        }

        var invokedVisitTupleType = false

        override func visitTupleType(_ element: TupleType) {
            super.visitTupleType(element)
            invokedVisitTupleType = true
        }

        var invokedVisitTupleTypeElement = false

        override func visitTupleTypeElement(_ element: TupleTypeElement) {
            super.visitTupleTypeElement(element)
            invokedVisitTupleTypeElement = true
        }

        var invokedVisitTypeAnnotation = false

        override func visitTypeAnnotation(_ element: TypeAnnotation) {
            super.visitTypeAnnotation(element)
            invokedVisitTypeAnnotation = true
        }

        var invokedVisitFunctionType = false

        override func visitFunctionType(_ element: FunctionType) {
            super.visitFunctionType(element)
            invokedVisitFunctionType = true
        }

        var invokedVisitTypealiasDeclaration = false

        override func visitTypealiasDeclaration(_ element: TypealiasDeclaration) {
            super.visitTypealiasDeclaration(element)
            invokedVisitTypealiasDeclaration = true
        }

        var invokedVisitTypealiasAssignment = false

        override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
            super.visitTypealiasAssignment(element)
            invokedVisitTypealiasAssignment = true
        }

        var invokedVisitParameter = false

        override func visitParameter(_ element: Parameter) {
            super.visitParameter(element)
            invokedVisitParameter = true
        }

        var invokedVisitInitializerDeclaration = false

        override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
            super.visitInitializerDeclaration(element)
            invokedVisitInitializerDeclaration = true
        }

        var invokedVisitSubscriptDeclaration = false

        override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
            super.visitSubscriptDeclaration(element)
            invokedVisitSubscriptDeclaration = true
        }

        var invokedVisitAccessLevelModifier = false

        override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
            super.visitAccessLevelModifier(element)
            invokedVisitAccessLevelModifier = true
        }

        var invokedVisitProtocolCompositionType = false

        override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
            super.visitProtocolCompositionType(element)
            invokedVisitProtocolCompositionType = true
        }

        var invokedVisitGetterSetterKeywordBlock = false

        override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
            super.visitGetterSetterKeywordBlock(element)
            invokedVisitGetterSetterKeywordBlock = true
        }
    }
}
