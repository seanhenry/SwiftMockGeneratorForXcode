import XCTest
@testable import SwiftStructureInterface
@testable import MockGenerator

class ResolvePerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"
    
    func test_generatesSimpleMock() { // 0.005
        measure { resolve("SimpleProtocolMock") }
    }
    
    func test_deletesMockBody() { // 0.08
        measure { resolve("DeleteBodyMock") }
    }
    
    func test_generatesReturnStubs() { // 0.145
        measure { resolve("ReturnProtocolMock") }
    }
    
    func test_generatesPropertyMock() { // 0.1
        measure { resolve("PropertyProtocolMock") }
    }
    
    func test_catchesMethodParameterInvocations() { // 0.58
        measure { resolve("MethodParameterProtocolMock") }
    }
    
    func test_addsDefaultValuesToStubsWherePossible() { // 0.157
        measure { resolve("DefaultValuesMock") }
    }
    
    func test_escapesKeywords() { // 0.58
        measure { resolve("KeywordsMock") }
    }
    
    func test_handlesOverloadedMethodsAndProperties() { // 1.1
        measure { resolve("OverloadProtocolMock") }
    }
    
    func test_closureSupport() { // 0.888
        measure { resolve("ClosureProtocolMock") }
    }
    
    func test_annotationSupport() { // 0.273
        measure { resolve("ParameterAnnotationMock") }
    }
    
    func test_typealiasSupport() { // 0.6
        measure { resolve("TypealiasProtocolMock") }
    }
    
    func test_handlesGenericMethods() { // 1.2
        measure { resolve("GenericMethodMock") }
    }
    
    func test_throwingSupport() { // 0.3
        measure { resolve("ThrowingProtocolMock") }
    }
    
    func test_protocolInitializer() { // 0.534
        measure { resolve("InitialiserProtocolMock") }
    }
    
    func test_multipleProtocol() { // 0.243
        measure { resolve("MultipleProtocolMock") }
    }
    
    func test_deepInheritance() { // 0.365
        measure { resolve("DeepInheritanceMock") }
    }
    
    func test_diamondInheritance() { // 0.138
        measure { resolve("DiamondInheritanceProtocolMock") }
    }
    
    func test_overloadingAcrossProtocols() { // 0.255
        measure { resolve("RecursiveProtocolMock") }
    }
    
    func test_generatesFromTupleTypes() { // 0.505
        measure {
            resolve("TupleProtocolMock")
        }
    }
    
    func resolve(_ testFile: String) {
        let sourceFiles = SourceFileFinder(projectRoot: URL(fileURLWithPath: testProject)).findSourceFiles()
        let fileContents = try! String(contentsOfFile: "\(testProject)/\(testFile).swift")
        let (contents, _) = CaretTestHelper.findCaretOffset(fileContents)
        let classFile = SKElementFactoryTestHelper.build(from: contents)!
        let classElement = classFile.typeDeclarations[0]
        _ = TypeDeclarationTransformingVisitor.transformMock(classElement, resolver: ResolverFactory.createResolver(filePaths: sourceFiles))
    }
}
