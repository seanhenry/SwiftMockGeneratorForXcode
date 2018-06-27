import XCTest
@testable import SwiftStructureInterface

class ManagedElementVisitorTests: XCTestCase {

    func test_all() {
        XCTAssertEqual(allTestElements.count, 24)
        assertProxyIsImplemented(testFile) { $0 is File }

        assertProxyIsImplemented(testElement) { _ in true }
        assertProxyIsImplemented(testElement.file) { $0 is File }
        assertProxyIsImplemented(testElement.parent) { _ in true }

        assertProxyIsImplemented(testTypeDeclaration) { $0 is TypeDeclaration }
        assertProxyIsImplemented(testTypeDeclaration.accessLevelModifier) { $0 is AccessLevelModifier }

        assertProxyIsImplemented(testAccessLevelModifier) { $0 is AccessLevelModifier }

        assertProxyIsImplemented(testInitializerDeclaration) { $0 is InitializerDeclaration }
        assertProxyIsImplemented(testInitializerDeclaration.parameterClause.parameters[0]) { $0 is Parameter }

        assertProxyIsImplemented(testVariableDeclaration) { $0 is VariableDeclaration }
        assertProxyIsImplemented(testVariableDeclaration.typeAnnotation) { $0 is TypeAnnotation }
        assertProxyIsImplemented(testVariableDeclaration.typeAnnotation.attributes) { $0 is Attributes }
        assertProxyIsImplemented(testVariableDeclaration.typeAnnotation.type) { $0 is Type }

        assertProxyIsImplemented(testParameter) { $0 is Parameter }
        assertProxyIsImplemented(testParameter.typeAnnotation) { $0 is TypeAnnotation }

        assertProxyIsImplemented(testGenericParameterClause) { $0 is GenericParameterClause }
        assertProxyIsImplemented(testGenericParameterClause.parameters[0]) { $0 is GenericParameter }

        assertProxyIsImplemented(testGenericParameter) { $0 is GenericParameter }

        let typeIdentifierParameter = testGenericParameterClause.parameters.first { $0.typeIdentifier != nil }
        assertProxyIsImplemented(typeIdentifierParameter?.typeIdentifier) { $0 is TypeIdentifier }

        let protocolCompositionParameter = testGenericParameterClause.parameters.first { $0.protocolComposition != nil }
        assertProxyIsImplemented(protocolCompositionParameter?.protocolComposition) { $0 is ProtocolCompositionType }

        assertProxyIsImplemented(testSubscriptDeclaration) { $0 is SubscriptDeclaration }

        assertProxyIsImplemented(testTypealiasDeclaration) { $0 is TypealiasDeclaration }
        assertProxyIsImplemented(testTypealiasDeclaration.typealiasAssignment) { $0 is TypealiasAssignment }

        assertProxyIsImplemented(testTypealiasAssignment) { $0 is TypealiasAssignment }
        assertProxyIsImplemented(testTypealiasAssignment.type) { $0 is Type }

        assertProxyIsImplemented(testTypeAnnotation) { $0 is TypeAnnotation }
        assertProxyIsImplemented(testTypeAnnotation.type) { $0 is Type }
        
        assertProxyIsImplemented(testTupleTypeElement) { $0 is TupleTypeElement }
        assertProxyIsImplemented(testTupleTypeElement.typeAnnotation) { $0 is TypeAnnotation }

        assertProxyIsImplemented(testFunctionDeclaration) { $0 is FunctionDeclaration }
        assertProxyIsImplemented(testFunctionDeclaration.parameterClause.parameters[0]) { $0 is Parameter }

        let returnFunction = testTypeDeclaration.functionDeclarations.first { $0.returnType != nil }
        assertProxyIsImplemented(returnFunction?.returnType) { $0 is FunctionResult }

        let genericFunction = testTypeDeclaration.functionDeclarations.first { $0.genericParameterClause != nil }
        assertProxyIsImplemented(genericFunction?.genericParameterClause) { $0 is GenericParameterClause }

        assertProxyIsImplemented(testType) { $0 is Type }

        assertProxyIsImplemented(testTypeIdentifier) { $0 is TypeIdentifier }

        assertProxyIsImplemented(testTupleType) { $0 is TupleType }
        assertProxyIsImplemented(testTupleType.tupleTypeElementList) { $0 is TupleTypeElementList }
        assertProxyIsImplemented(testTupleType.tupleTypeElementList.tupleTypeElements[0]) { $0 is TupleTypeElement }

        assertProxyIsImplemented(testArrayType) { $0 is ArrayType }
        assertProxyIsImplemented(testArrayType.elementType) { $0 is Type }

        assertProxyIsImplemented(testDictionaryType) { $0 is DictionaryType }
        assertProxyIsImplemented(testDictionaryType.keyType) { $0 is Type }
        assertProxyIsImplemented(testDictionaryType.valueType) { $0 is Type }

        assertProxyIsImplemented(testOptionalType) { $0 is OptionalType }
        assertProxyIsImplemented(testOptionalType.type) { $0 is Type }

        assertProxyIsImplemented(testFunctionType) { $0 is FunctionType }
        assertProxyIsImplemented(testFunctionType.arguments) { $0 is TupleType }
        assertProxyIsImplemented(testFunctionType.returnType) { $0 is Type }

        assertProxyIsImplemented(testProtocolCompositionType) { $0 is ProtocolCompositionType }
        assertProxyIsImplemented(testProtocolCompositionType.types[0]) { $0 is Type }

        assertProxyIsImplemented(testGetterSetterKeywordBlock) { $0 is GetterSetterKeywordBlock }
    }

    private func assertProxyIsImplemented(_ element: Element?, line: UInt = #line, _ isType: (Element) -> Bool) {
        XCTAssertNotNil(element, line: line)
        guard let proxy = element as? ElementProxy else {
            XCTFail("\(type(of: element)) is not wrapped", line: line)
            return
        }
        XCTAssertTrue(isType(proxy), "Proxy type '\(type(of: proxy))' was not the right type", line: line)
        XCTAssertTrue(isType(proxy.managed), "Managed type '\(type(of: proxy.managed))' was not the right type", line: line)
    }
}
