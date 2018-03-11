@testable import SwiftStructureInterface

class MockRecursiveVisitor: RecursiveElementVisitor {

    var invokedVisitElement = false
    var invokedVisitElementCount = 0
    var invokedVisitElementParameters: (element: Element, Void)?
    var invokedVisitElementParametersList = [(element: Element, Void)]()

    override func visitElement(_ element: Element) {
        invokedVisitElement = true
        invokedVisitElementCount += 1
        invokedVisitElementParameters = (element, ())
        invokedVisitElementParametersList.append((element, ()))
        super.visitElement(element)
    }

    var invokedVisitTypeDeclaration = false
    var invokedVisitTypeDeclarationCount = 0
    var invokedVisitTypeDeclarationParameters: (element: TypeDeclaration, Void)?
    var invokedVisitTypeDeclarationParametersList = [(element: TypeDeclaration, Void)]()

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
        invokedVisitTypeDeclaration = true
        invokedVisitTypeDeclarationCount += 1
        invokedVisitTypeDeclarationParameters = (element, ())
        invokedVisitTypeDeclarationParametersList.append((element, ()))
        super.visitTypeDeclaration(element)
    }

    var invokedVisitFile = false
    var invokedVisitFileCount = 0
    var invokedVisitFileParameters: (element: File, Void)?
    var invokedVisitFileParametersList = [(element: File, Void)]()

    override func visitFile(_ element: File) {
        invokedVisitFile = true
        invokedVisitFileCount += 1
        invokedVisitFileParameters = (element, ())
        invokedVisitFileParametersList.append((element, ()))
        super.visitFile(element)
    }

    var invokedVisitFunctionDeclaration = false
    var invokedVisitFunctionDeclarationCount = 0
    var invokedVisitFunctionDeclarationParameters: (element: FunctionDeclaration, Void)?
    var invokedVisitFunctionDeclarationParametersList = [(element: FunctionDeclaration, Void)]()

    override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        invokedVisitFunctionDeclaration = true
        invokedVisitFunctionDeclarationCount += 1
        invokedVisitFunctionDeclarationParameters = (element, ())
        invokedVisitFunctionDeclarationParametersList.append((element, ()))
        super.visitFunctionDeclaration(element)
    }

    var invokedVisitVariableDeclaration = false
    var invokedVisitVariableDeclarationCount = 0
    var invokedVisitVariableDeclarationParameters: (element: VariableDeclaration, Void)?
    var invokedVisitVariableDeclarationParametersList = [(element: VariableDeclaration, Void)]()

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        invokedVisitVariableDeclaration = true
        invokedVisitVariableDeclarationCount += 1
        invokedVisitVariableDeclarationParameters = (element, ())
        invokedVisitVariableDeclarationParametersList.append((element, ()))
        super.visitVariableDeclaration(element)
    }

    var invokedVisitGenericParameterClause = false
    var invokedVisitGenericParameterClauseCount = 0
    var invokedVisitGenericParameterClauseParameters: (element: GenericParameterClause, Void)?
    var invokedVisitGenericParameterClauseParametersList = [(element: GenericParameterClause, Void)]()

    override func visitGenericParameterClause(_ element: GenericParameterClause) {
        invokedVisitGenericParameterClause = true
        invokedVisitGenericParameterClauseCount += 1
        invokedVisitGenericParameterClauseParameters = (element, ())
        invokedVisitGenericParameterClauseParametersList.append((element, ()))
        super.visitGenericParameterClause(element)
    }
}
