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

    func test_visit_fileShouldVisitAncestors() {
        emptyFile.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeDeclarationShouldVisitAncestors() {
        emptyTypeDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypeDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_functionDeclarationShouldVisitAncestors() {
        emptyFunctionDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_variableDeclarationShouldVisitAncestors() {
        emptyVariableDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_genericParameterClauseShouldVisitAncestors() {
        testGenericParameterClause.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeShouldVisitAncestors() {
        testType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typealiasShouldVisitAncestors() {
        testTypealias.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typealiasAssignmentShouldVisitAncestors() {
        testTypealiasAssignment.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_functionParameterShouldVisitAncestors() {
        testFunctionParameter.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    // MARK: - Helpers

    class PartialMockVisitor: ElementVisitor {

        var invokedVisitElement = false
        var invokedVisitElementCount = 0
        var invokedVisitElementParameters: (element: Element, Void)?
        var invokedVisitElementParametersList = [(element: Element, Void)]()

        override func visitElement(_ element: Element) {
            super.visitElement(element)
            invokedVisitElement = true
            invokedVisitElementCount += 1
            invokedVisitElementParameters = (element, ())
            invokedVisitElementParametersList.append((element, ()))
        }

        var invokedVisitTypeDeclaration = false
        var invokedVisitTypeDeclarationCount = 0
        var invokedVisitTypeDeclarationParameters: (element: TypeDeclaration, Void)?
        var invokedVisitTypeDeclarationParametersList = [(element: TypeDeclaration, Void)]()

        override func visitTypeDeclaration(_ element: TypeDeclaration) {
            super.visitTypeDeclaration(element)
            invokedVisitTypeDeclaration = true
            invokedVisitTypeDeclarationCount += 1
            invokedVisitTypeDeclarationParameters = (element, ())
            invokedVisitTypeDeclarationParametersList.append((element, ()))
        }

        var invokedVisitFile = false
        var invokedVisitFileCount = 0
        var invokedVisitFileParameters: (element: File, Void)?
        var invokedVisitFileParametersList = [(element: File, Void)]()

        override func visitFile(_ element: File) {
            super.visitFile(element)
            invokedVisitFile = true
            invokedVisitFileCount += 1
            invokedVisitFileParameters = (element, ())
            invokedVisitFileParametersList.append((element, ()))
        }

        var invokedVisitFunctionDeclaration = false
        var invokedVisitFunctionDeclarationCount = 0
        var invokedVisitFunctionDeclarationParameters: (element: FunctionDeclaration, Void)?
        var invokedVisitFunctionDeclarationParametersList = [(element: FunctionDeclaration, Void)]()

        override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
            super.visitFunctionDeclaration(element)
            invokedVisitFunctionDeclaration = true
            invokedVisitFunctionDeclarationCount += 1
            invokedVisitFunctionDeclarationParameters = (element, ())
            invokedVisitFunctionDeclarationParametersList.append((element, ()))
        }

        var invokedVisitSwiftVariableDeclaration = false
        var invokedVisitSwiftVariableDeclarationCount = 0
        var invokedVisitSwiftVariableDeclarationParameters: (element: VariableDeclaration, Void)?
        var invokedVisitSwiftVariableDeclarationParametersList = [(element: VariableDeclaration, Void)]()

        override func visitVariableDeclaration(_ element: VariableDeclaration) {
            super.visitVariableDeclaration(element)
            invokedVisitSwiftVariableDeclaration = true
            invokedVisitSwiftVariableDeclarationCount += 1
            invokedVisitSwiftVariableDeclarationParameters = (element, ())
            invokedVisitSwiftVariableDeclarationParametersList.append((element, ()))
        }

        var invokedVisitGenericParameterClause = false
        var invokedVisitGenericParameterClauseCount = 0
        var invokedVisitGenericParameterClauseParameters: (element: GenericParameterClause, Void)?
        var invokedVisitGenericParameterClauseParametersList = [(element: GenericParameterClause, Void)]()

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            super.visitGenericParameterClause(element)
            invokedVisitGenericParameterClause = true
            invokedVisitGenericParameterClauseCount += 1
            invokedVisitGenericParameterClauseParameters = (element, ())
            invokedVisitGenericParameterClauseParametersList.append((element, ()))
        }

        var invokedVisitType = false
        var invokedVisitTypeCount = 0
        var invokedVisitTypeParameters: (element: Type, Void)?
        var invokedVisitTypeParametersList = [(element: Type, Void)]()

        override func visitType(_ element: Type) {
            super.visitType(element)
            invokedVisitType = true
            invokedVisitTypeCount += 1
            invokedVisitTypeParameters = (element, ())
            invokedVisitTypeParametersList.append((element, ()))
        }

        var invokedVisitTypealias = false
        var invokedVisitTypealiasCount = 0
        var invokedVisitTypealiasParameters: (element: Typealias, Void)?
        var invokedVisitTypealiasParametersList = [(element: Typealias, Void)]()

        override func visitTypealias(_ element: Typealias) {
            super.visitTypealias(element)
            invokedVisitTypealias = true
            invokedVisitTypealiasCount += 1
            invokedVisitTypealiasParameters = (element, ())
            invokedVisitTypealiasParametersList.append((element, ()))
        }

        var invokedVisitTypealiasAssignment = false
        var invokedVisitTypealiasAssignmentCount = 0
        var invokedVisitTypealiasAssignmentParameters: (element: TypealiasAssignment, Void)?
        var invokedVisitTypealiasAssignmentParametersList = [(element: TypealiasAssignment, Void)]()

        override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
            super.visitTypealiasAssignment(element)
            invokedVisitTypealiasAssignment = true
            invokedVisitTypealiasAssignmentCount += 1
            invokedVisitTypealiasAssignmentParameters = (element, ())
            invokedVisitTypealiasAssignmentParametersList.append((element, ()))
        }

        var invokedVisitParameter = false
        var invokedVisitParameterCount = 0
        var invokedVisitParameterParameters: (element: Parameter, Void)?
        var invokedVisitParameterParametersList = [(element: Parameter, Void)]()

        override func visitParameter(_ element: Parameter) {
            super.visitParameter(element)
            invokedVisitParameter = true
            invokedVisitParameterCount += 1
            invokedVisitParameterParameters = (element, ())
            invokedVisitParameterParametersList.append((element, ()))
        }
    }
}
