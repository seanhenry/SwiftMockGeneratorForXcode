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

    func test_generatesSimpleClass() {
        assertMockGeneratesExpected("SimpleClassMock")
    }

    func test_generatesClassMockWithThrowingMembers() {
        assertMockGeneratesExpected("ThrowingClassMock")
    }

    func test_generatesClassMockInheritingAnotherClass() {
        assertMockGeneratesExpected("SuperclassMock")
    }

    func test_choosesSimplestInitializerForClassMock() {
        assertMockGeneratesExpected("MultipleInitializerClassMock")
    }

    func test_generatesInitializerWithArgumentsForClassMock() {
        assertMockGeneratesExpected("ArgumentInitializerClassMock")
    }

    func test_generatesMembersFromClassesAndProtocols() {
        assertMockGeneratesExpected("ClassAndProtocolMock")
    }

    func test_handlesEmptyFailableInitializerForClassMock() {
        assertMockGeneratesExpected("EmptyFailableInitializerClassMock")
    }

    func test_handlesFailableInitializerForClassMock() {
        assertMockGeneratesExpected("FailableInitializerClassMock")
    }

    func test_handlesAvailableAttributeForClassMock() {
        assertMockGeneratesExpected("AvailableClassMock")
    }

    func test_handlesClassRequiredInitializers() {
        assertMockGeneratesExpected("RequiredInitializerClassMock")
    }

    func test_handlesClassPrivateInitializers() {
        assertMockGeneratesExpected("PrivateInitializerClassMock")
    }

    func test_supportsClassProperties() {
        assertMockGeneratesExpected("PropertyClassMock")
    }

    func test_stripsModifiers() {
        assertMockGeneratesExpected("ModifierClassMock")
    }

    func test_supportsDefaultArgumentsInMethods() {
        assertMockGeneratesExpected("DefaultArgumentClassMock")
    }

    func test_readOnlySubscript() {
        assertMockGeneratesExpected("ReadOnlySubscriptProtocolMock")
    }

    func test_readWriteSubscript() {
        assertMockGeneratesExpected("SubscriptProtocolMock")
    }

    func test_subscriptWithArguments() {
        assertMockGeneratesExpected("ArgumentsSubscriptProtocolMock")
    }

    func test_subscriptWithOverloads() {
        assertMockGeneratesExpected("OverloadedSubscriptProtocolMock")
    }

    func test_subscriptInClass() {
        assertMockGeneratesExpected("ClassSubscriptMock")
    }

    func test_overriddenSubscripts() {
        assertMockGeneratesExpected("AugmentedClassSubscriptMock")
    }

    func test_returnsErrorWhenSDKPathDoesNotExist() {
        let preferences = Preferences()
        let moduleCachePath = preferences.moduleCachePath
        preferences.moduleCachePath = "/path/to/nowhere"
        assertMockGeneratesError(fileName: "SimpleProtocolMock", "The module cache path does not exist. Change it in the companion app.")
        preferences.moduleCachePath = moduleCachePath
    }
}
