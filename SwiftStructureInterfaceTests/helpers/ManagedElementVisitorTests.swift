import XCTest
@testable import SwiftStructureInterface

class ManagedElementVisitorTests: XCTestCase {

    func test_all() {
        XCTAssertEqual(allTestElements.count, 24)
        assertWrapperIsImplemented(testFile) { $0 is File }

        assertWrapperIsImplemented(testElement) { _ in true }
        assertWrapperIsImplemented(testElement.file) { $0 is File }
        assertWrapperIsImplemented(testElement.parent) { _ in true }

        assertWrapperIsImplemented(testTypeDeclaration) { $0 is TypeDeclaration }
        assertWrapperIsImplemented(testTypeDeclaration.accessLevelModifier) { $0 is AccessLevelModifier }

        assertWrapperIsImplemented(testAccessLevelModifier) { $0 is AccessLevelModifier }

        assertWrapperIsImplemented(testInitializerDeclaration) { $0 is InitializerDeclaration
        }
        assertWrapperIsImplemented(testInitializerDeclaration.parameters[0]) { $0 is Parameter }

        assertWrapperIsImplemented(testVariableDeclaration) { $0 is VariableDeclaration }
        assertWrapperIsImplemented(testVariableDeclaration.type) { $0 is Type }

        assertWrapperIsImplemented(testParameter) { $0 is Parameter }
        assertWrapperIsImplemented(testParameter.typeAnnotation) { $0 is TypeAnnotation }

        assertWrapperIsImplemented(testGenericParameterClause) { $0 is GenericParameterClause }
        assertWrapperIsImplemented(testGenericParameterClause.parameters[0]) { $0 is GenericParameter }

        assertWrapperIsImplemented(testGenericParameter) { $0 is GenericParameter }
        assertWrapperIsImplemented(testGenericParameter.typeIdentifier) { $0 is TypeIdentifier }
        assertWrapperIsImplemented(testGenericParameterClause.parameters[1].protocolComposition) { $0 is ProtocolCompositionType }

        assertWrapperIsImplemented(testSubscriptDeclaration) { $0 is SubscriptDeclaration }

        assertWrapperIsImplemented(testTypealiasDeclaration) { $0 is TypealiasDeclaration }
        assertWrapperIsImplemented(testTypealiasDeclaration.typealiasAssignment) { $0 is TypealiasAssignment }

        assertWrapperIsImplemented(testTypealiasAssignment) { $0 is TypealiasAssignment }
        assertWrapperIsImplemented(testTypealiasAssignment.type) { $0 is Type }

        assertWrapperIsImplemented(testTypeAnnotation) { $0 is TypeAnnotation }
        assertWrapperIsImplemented(testTypeAnnotation.type) { $0 is Type }
        
        assertWrapperIsImplemented(testTupleTypeElement) { $0 is TupleTypeElement }
        assertWrapperIsImplemented(testTupleTypeElement.typeAnnotation) { $0 is TypeAnnotation }

        assertWrapperIsImplemented(testFunctionDeclaration) { $0 is FunctionDeclaration }
        assertWrapperIsImplemented(testFunctionDeclaration.parameters[0]) { $0 is Parameter }
        assertWrapperIsImplemented(testFunctionDeclaration.genericParameterClause) { $0 is GenericParameterClause }
        assertWrapperIsImplemented(testFunctionDeclaration.returnType) { $0 is Type }

        assertWrapperIsImplemented(testType) { $0 is Type }

        assertWrapperIsImplemented(testTypeIdentifier) { $0 is TypeIdentifier }
        assertWrapperIsImplemented(testTypeIdentifier.parentType) { $0 is TypeIdentifier }

        assertWrapperIsImplemented(testGenericTypeIdentifier.genericArguments[0]) { $0 is Type }

        assertWrapperIsImplemented(testTupleType) { $0 is TupleType }
        assertWrapperIsImplemented(testTupleType.elements[0]) { $0 is TupleTypeElement }

        assertWrapperIsImplemented(testArrayType) { $0 is ArrayType }
        assertWrapperIsImplemented(testArrayType.elementType) { $0 is Type }

        assertWrapperIsImplemented(testDictionaryType) { $0 is DictionaryType }
        assertWrapperIsImplemented(testDictionaryType.keyType) { $0 is Type }
        assertWrapperIsImplemented(testDictionaryType.valueType) { $0 is Type }

        assertWrapperIsImplemented(testOptionalType) { $0 is OptionalType }
        assertWrapperIsImplemented(testOptionalType.type) { $0 is Type }

        assertWrapperIsImplemented(testFunctionType) { $0 is FunctionType }
        assertWrapperIsImplemented(testFunctionType.arguments) { $0 is TupleType }
        assertWrapperIsImplemented(testFunctionType.returnType) { $0 is Type }

        assertWrapperIsImplemented(testProtocolCompositionType) { $0 is ProtocolCompositionType }
        assertWrapperIsImplemented(testProtocolCompositionType.types[0]) { $0 is Type }

        assertWrapperIsImplemented(testGetterSetterKeywordBlock) { $0 is GetterSetterKeywordBlock }
    }

    private func assertWrapperIsImplemented(_ element: Element?, line: UInt = #line, _ isType: (Element) -> Bool) {
        guard let wrapper = element as? ElementWrapper else {
            XCTFail("\(type(of: element)) is not wrapped", line: line)
            return
        }
        XCTAssertTrue(isType(wrapper), "Wrapper type '\(type(of: wrapper))' was not the right type", line: line)
        XCTAssertTrue(isType(wrapper.managed), "Managed type '\(type(of: wrapper.managed))' was not the right type", line: line)
    }
}
