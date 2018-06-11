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
        XCTAssertEqual(visitor.invokedVisitFileCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeDeclarationShouldVisitAncestors() {
        emptyTypeDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypeDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_functionDeclarationShouldVisitAncestors() {
        emptyFunctionDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitFunctionDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_variableDeclarationShouldVisitAncestors() {
        emptyVariableDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitVariableDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_genericParameterClauseShouldVisitAncestors() {
        testGenericParameterClause.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitGenericParameterClauseCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeShouldVisitAncestors() {
        testType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typealiasShouldVisitAncestors() {
        testTypealias.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypealiasCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typealiasAssignmentShouldVisitAncestors() {
        testTypealiasAssignment.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypealiasAssignmentCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_parameterShouldVisitAncestors() {
        testFunctionParameter.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitParameterCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_arrayTypeShouldVisitAncestors() {
        testArrayType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitArrayTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_dictionaryTypeShouldVisitAncestors() {
        testDictionaryType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitDictionaryTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_optionalTypeShouldVisitAncestors() {
        testOptionalType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitOptionalTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_initialiserDeclarationShouldVisitAncestors() {
        testInitialiserDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitInitialiserDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_subscriptDeclarationShouldVisitAncestors() {
        testSubscriptDeclaration.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitSubscriptDeclarationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeIdentifierShouldVisitAncestors() {
        testTypeIdentifier.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypeIdentifierCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_tupleTypeShouldVisitAncestors() {
        testTupleType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTupleTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_tupleTypeElementShouldVisitAncestors() {
        testTupleTypeElement.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTupleTypeElementCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_typeAnnotationShouldVisitAncestors() {
        testTypeAnnotation.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitTypeAnnotationCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_functionTypeShouldVisitAncestors() {
        testFunctionType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitFunctionTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_genericParameterShouldVisitAncestors() {
        testGenericParameter.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitGenericParameterCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_accessLevelModifier() {
        testAccessLevelModifier.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitAccessLevelModifierCount, 1)
        XCTAssertEqual(visitor.invokedVisitElementCount, 1)
    }

    func test_visit_protocolCompositionType() {
        testProtocolCompositionType.accept(visitor)
        XCTAssertEqual(visitor.invokedVisitProtocolCompositionTypeCount, 1)
        XCTAssertEqual(visitor.invokedVisitTypeCount, 1)
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

        var invokedVisitVariableDeclaration = false
        var invokedVisitVariableDeclarationCount = 0
        var invokedVisitVariableDeclarationParameters: (element: VariableDeclaration, Void)?
        var invokedVisitVariableDeclarationParametersList = [(element: VariableDeclaration, Void)]()

        override func visitVariableDeclaration(_ element: VariableDeclaration) {
            super.visitVariableDeclaration(element)
            invokedVisitVariableDeclaration = true
            invokedVisitVariableDeclarationCount += 1
            invokedVisitVariableDeclarationParameters = (element, ())
            invokedVisitVariableDeclarationParametersList.append((element, ()))
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

        var invokedVisitGenericParameter = false
        var invokedVisitGenericParameterCount = 0
        var invokedVisitGenericParameterParameters: (element: GenericParameter, Void)?
        var invokedVisitGenericParameterParametersList = [(element: GenericParameter, Void)]()

        override func visitGenericParameter(_ element: GenericParameter) {
            super.visitGenericParameter(element)
            invokedVisitGenericParameter = true
            invokedVisitGenericParameterCount += 1
            invokedVisitGenericParameterParameters = (element, ())
            invokedVisitGenericParameterParametersList.append((element, ()))
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

        var invokedVisitArrayType = false
        var invokedVisitArrayTypeCount = 0
        var invokedVisitArrayTypeParameters: (element: ArrayType, Void)?
        var invokedVisitArrayTypeParametersList = [(element: ArrayType, Void)]()

        override func visitArrayType(_ element: ArrayType) {
            super.visitArrayType(element)
            invokedVisitArrayType = true
            invokedVisitArrayTypeCount += 1
            invokedVisitArrayTypeParameters = (element, ())
            invokedVisitArrayTypeParametersList.append((element, ()))
        }

        var invokedVisitDictionaryType = false
        var invokedVisitDictionaryTypeCount = 0
        var invokedVisitDictionaryTypeParameters: (element: DictionaryType, Void)?
        var invokedVisitDictionaryTypeParametersList = [(element: DictionaryType, Void)]()

        override func visitDictionaryType(_ element: DictionaryType) {
            super.visitDictionaryType(element)
            invokedVisitDictionaryType = true
            invokedVisitDictionaryTypeCount += 1
            invokedVisitDictionaryTypeParameters = (element, ())
            invokedVisitDictionaryTypeParametersList.append((element, ()))
        }

        var invokedVisitOptionalType = false
        var invokedVisitOptionalTypeCount = 0
        var invokedVisitOptionalTypeParameters: (element: OptionalType, Void)?
        var invokedVisitOptionalTypeParametersList = [(element: OptionalType, Void)]()

        override func visitOptionalType(_ element: OptionalType) {
            super.visitOptionalType(element)
            invokedVisitOptionalType = true
            invokedVisitOptionalTypeCount += 1
            invokedVisitOptionalTypeParameters = (element, ())
            invokedVisitOptionalTypeParametersList.append((element, ()))
        }

        var invokedVisitTypeIdentifier = false
        var invokedVisitTypeIdentifierCount = 0
        var invokedVisitTypeIdentifierParameters: (element: TypeIdentifier, Void)?
        var invokedVisitTypeIdentifierParametersList = [(element: TypeIdentifier, Void)]()

        override func visitTypeIdentifier(_ element: TypeIdentifier) {
            super.visitTypeIdentifier(element)
            invokedVisitTypeIdentifier = true
            invokedVisitTypeIdentifierCount += 1
            invokedVisitTypeIdentifierParameters = (element, ())
            invokedVisitTypeIdentifierParametersList.append((element, ()))
        }

        var invokedVisitTupleType = false
        var invokedVisitTupleTypeCount = 0
        var invokedVisitTupleTypeParameters: (element: TupleType, Void)?
        var invokedVisitTupleTypeParametersList = [(element: TupleType, Void)]()

        override func visitTupleType(_ element: TupleType) {
            super.visitTupleType(element)
            invokedVisitTupleType = true
            invokedVisitTupleTypeCount += 1
            invokedVisitTupleTypeParameters = (element, ())
            invokedVisitTupleTypeParametersList.append((element, ()))
        }

        var invokedVisitTupleTypeElement = false
        var invokedVisitTupleTypeElementCount = 0
        var invokedVisitTupleTypeElementParameters: (element: TupleTypeElement, Void)?
        var invokedVisitTupleTypeElementParametersList = [(element: TupleTypeElement, Void)]()

        override func visitTupleTypeElement(_ element: TupleTypeElement) {
            super.visitTupleTypeElement(element)
            invokedVisitTupleTypeElement = true
            invokedVisitTupleTypeElementCount += 1
            invokedVisitTupleTypeElementParameters = (element, ())
            invokedVisitTupleTypeElementParametersList.append((element, ()))
        }

        var invokedVisitTypeAnnotation = false
        var invokedVisitTypeAnnotationCount = 0
        var invokedVisitTypeAnnotationParameters: (element: TypeAnnotation, Void)?
        var invokedVisitTypeAnnotationParametersList = [(element: TypeAnnotation, Void)]()

        override func visitTypeAnnotation(_ element: TypeAnnotation) {
            super.visitTypeAnnotation(element)
            invokedVisitTypeAnnotation = true
            invokedVisitTypeAnnotationCount += 1
            invokedVisitTypeAnnotationParameters = (element, ())
            invokedVisitTypeAnnotationParametersList.append((element, ()))
        }

        var invokedVisitFunctionType = false
        var invokedVisitFunctionTypeCount = 0
        var invokedVisitFunctionTypeParameters: (element: FunctionType, Void)?
        var invokedVisitFunctionTypeParametersList = [(element: FunctionType, Void)]()

        override func visitFunctionType(_ element: FunctionType) {
            super.visitFunctionType(element)
            invokedVisitFunctionType = true
            invokedVisitFunctionTypeCount += 1
            invokedVisitFunctionTypeParameters = (element, ())
            invokedVisitFunctionTypeParametersList.append((element, ()))
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

        var invokedVisitInitialiserDeclaration = false
        var invokedVisitInitialiserDeclarationCount = 0
        var invokedVisitInitialiserDeclarationParameters: (element: InitialiserDeclaration, Void)?
        var invokedVisitInitialiserDeclarationParametersList = [(element: InitialiserDeclaration, Void)]()

        override func visitInitialiserDeclaration(_ element: InitialiserDeclaration) {
            super.visitInitialiserDeclaration(element)
            invokedVisitInitialiserDeclaration = true
            invokedVisitInitialiserDeclarationCount += 1
            invokedVisitInitialiserDeclarationParameters = (element, ())
            invokedVisitInitialiserDeclarationParametersList.append((element, ()))
        }

        var invokedVisitSubscriptDeclaration = false
        var invokedVisitSubscriptDeclarationCount = 0
        var invokedVisitSubscriptDeclarationParameters: (element: SubscriptDeclaration, Void)?
        var invokedVisitSubscriptDeclarationParametersList = [(element: SubscriptDeclaration, Void)]()

        override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
            super.visitSubscriptDeclaration(element)
            invokedVisitSubscriptDeclaration = true
            invokedVisitSubscriptDeclarationCount += 1
            invokedVisitSubscriptDeclarationParameters = (element, ())
            invokedVisitSubscriptDeclarationParametersList.append((element, ()))
        }

        var invokedVisitAccessLevelModifier = false
        var invokedVisitAccessLevelModifierCount = 0
        var invokedVisitAccessLevelModifierParameters: (element: AccessLevelModifier, Void)?
        var invokedVisitAccessLevelModifierParametersList = [(element: AccessLevelModifier, Void)]()

        override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
            super.visitAccessLevelModifier(element)
            invokedVisitAccessLevelModifier = true
            invokedVisitAccessLevelModifierCount += 1
            invokedVisitAccessLevelModifierParameters = (element, ())
            invokedVisitAccessLevelModifierParametersList.append((element, ()))
        }

        var invokedVisitProtocolCompositionType = false
        var invokedVisitProtocolCompositionTypeCount = 0
        var invokedVisitProtocolCompositionTypeParameters: (element: ProtocolCompositionType, Void)?
        var invokedVisitProtocolCompositionTypeParametersList = [(element: ProtocolCompositionType, Void)]()

        override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
            super.visitProtocolCompositionType(element)
            invokedVisitProtocolCompositionType = true
            invokedVisitProtocolCompositionTypeCount += 1
            invokedVisitProtocolCompositionTypeParameters = (element, ())
            invokedVisitProtocolCompositionTypeParametersList.append((element, ()))
        }
    }
}
