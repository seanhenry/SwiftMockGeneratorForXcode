import XCTest
@testable import XcodePluginProxy

class EndToEndTests: MockGeneratorBaseTestCase {

    func test_generatesSimpleMock() {
        assertMockGeneratesExpected("SimpleProtocolMock")
    }

    func test_deletesMockBody() {
        assertMockGeneratesExpected("DeleteBodyMock")
    }

    func test_generatesReturnStubs() {
        assertMockGeneratesExpected("ReturnProtocolMock")
    }

    func test_generatesPropertyMock() {
        assertMockGeneratesExpected("PropertyProtocolMock")
    }

    func test_catchesMethodParameterInvocations() {
        assertMockGeneratesExpected("MethodParameterProtocolMock")
    }

    func test_addsDefaultValuesToStubsWherePossible() {
        assertMockGeneratesExpected("DefaultValuesMock")
    }

    func test_escapesKeywords() {
        assertMockGeneratesExpected("KeywordsMock")
    }

    func test_handlesOverloadedMethodsAndProperties() {
        assertMockGeneratesExpected("OverloadProtocolMock")
    }

    func test_closureSupport() {
        assertMockGeneratesExpected("ClosureProtocolMock")
    }

    func test_annotationSupport() {
        assertMockGeneratesExpected("ParameterAnnotationMock")
    }

    func test_typealiasSupport() {
        assertMockGeneratesExpected("TypealiasProtocolMock")
    }

    func test_handlesGenericMethods() {
        assertMockGeneratesExpected("GenericMethodMock")
    }

    func test_throwingSupport() {
        assertMockGeneratesExpected("ThrowingProtocolMock")
    }

    func test_protocolInitializer() {
        assertMockGeneratesExpected("InitialiserProtocolMock")
    }

    func test_multipleProtocol() {
        assertMockGeneratesExpected("MultipleProtocolMock")
    }

    func test_deepInheritance() {
        assertMockGeneratesExpected("DeepInheritanceMock")
    }

    func test_diamondInheritance() {
        assertMockGeneratesExpected("DiamondInheritanceProtocolMock")
    }

    func test_overloadingAcrossProtocols() {
        assertMockGeneratesExpected("RecursiveProtocolMock")
    }

    func test_generatesFromTupleTypes() {
        assertMockGeneratesExpected("TupleProtocolMock")
    }
}
