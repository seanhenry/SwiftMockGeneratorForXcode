import XCTest
import TestHelper
import Resolver
@testable import MockGenerator

class ResolvePerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"
    
    func test_generatesSimpleMock() {
        measure { resolve("SimpleProtocolMock") }
    }
    
    func test_deletesMockBody() {
        measure { resolve("DeleteBodyMock") }
    }
    
    func test_generatesReturnStubs() {
        measure { resolve("ReturnProtocolMock") }
    }
    
    func test_generatesPropertyMock() {
        measure { resolve("PropertyProtocolMock") }
    }
    
    func test_catchesMethodParameterInvocations() {
        measure { resolve("MethodParameterProtocolMock") }
    }
    
    func test_addsDefaultValuesToStubsWherePossible() {
        measure { resolve("DefaultValuesMock") }
    }
    
    func test_escapesKeywords() {
        measure { resolve("KeywordsMock") }
    }
    
    func test_handlesOverloadedMethodsAndProperties() {
        measure { resolve("OverloadProtocolMock") }
    }
    
    func test_closureSupport() {
        measure { resolve("ClosureProtocolMock") }
    }
    
    func test_annotationSupport() {
        measure { resolve("ParameterAnnotationMock") }
    }
    
    func test_typealiasSupport() {
        measure { resolve("TypealiasProtocolMock") }
    }
    
    func test_handlesGenericMethods() {
        measure { resolve("GenericMethodMock") }
    }
    
    func test_throwingSupport() {
        measure { resolve("ThrowingProtocolMock") }
    }
    
    func test_protocolInitializer() {
        measure { resolve("InitialiserProtocolMock") }
    }
    
    func test_multipleProtocol() {
        measure { resolve("MultipleProtocolMock") }
    }
    
    func test_deepInheritance() {
        measure { resolve("DeepInheritanceMock") }
    }
    
    func test_diamondInheritance() {
        measure { resolve("DiamondInheritanceProtocolMock") }
    }
    
    func test_overloadingAcrossProtocols() {
        measure { resolve("RecursiveProtocolMock") }
    }
    
    func test_generatesFromTupleTypes() {
        measure {
            resolve("TupleProtocolMock")
        }
    }
    
    func resolve(_ testFile: String) {
        let sourceFiles = SourceFileFinder(projectRoot: URL(fileURLWithPath: testProject)).findSourceFiles()
        let fileContents = try! String(contentsOfFile: "\(testProject)/\(testFile).swift")
        let (contents, _) = CaretTestHelper.findCaretOffset(fileContents)
        let classFile = try! ParserTestHelper.parseFile(from: contents)
        let classElement = classFile.typeDeclarations[0]
        _ = TypeDeclarationTransformingVisitor.transformMock(classElement, resolver: ResolverFactory.createResolver(filePaths: sourceFiles))
    }
}
