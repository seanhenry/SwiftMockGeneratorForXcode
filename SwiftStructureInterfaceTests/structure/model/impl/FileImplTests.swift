import XCTest
@testable import SwiftStructureInterface

class FileImplTests: XCTestCase {

    var file: File!

    override func tearDown() {
        file = nil
        super.tearDown()
    }

    // MARK: - init

    func test_init_shouldSetItselfToAllChildren() {
        file = ElementParser.parseFile(getProtocolString())
        assertFile(file.file)
        let protocolA = file.typeDeclarations[0]
        assertFile(protocolA.file)
        assertFile(protocolA.typeInheritanceClause.inheritedTypes[0].file)
        let initializer = protocolA.initializerDeclarations[0]
        assertFile(initializer.file)
        assertFile(initializer.parameterClause.parameters[0].file)
        assertFile(initializer.parameterClause.parameters[0].typeAnnotation.file)
        assertFile(initializer.parameterClause.parameters[0].typeAnnotation.type.file)
        let property = protocolA.variableDeclarations[0]
        assertFile(property.file)
        assertFile(property.typeAnnotation.file)
        assertFile(property.typeAnnotation.type.file)
        let method = protocolA.functionDeclarations[0]
        let methodParam = method.parameterClause.parameters[0]
        assertFile(method.file)
        assertFile(method.genericParameterClause?.file)
        assertFile(method.genericParameterClause?.parameters[0].file)
        assertFile(methodParam.file)
        assertFile(methodParam.typeAnnotation.file)
        assertFile(methodParam.typeAnnotation.type.file)
        assertFile(method.returnType?.file)
    }

    func test_fileShouldBePresent_whenProgramHoldsAReferenceToAChild() {
        var child: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getProtocolString())!
            child = file.children[0]
        }
        XCTAssertNotNil(child?.file)
    }

    func test_copyOfFile_shouldKeepStrongReferencesToChildren() {
        var fileCopy: Element?
        autoreleasepool {
            let file = SKElementFactoryTestHelper.build(from: getProtocolString())!
            fileCopy = file.children[0].file
        }
        XCTAssertEqual(fileCopy?.children.count, 1)
    }

    private func assertFile(_ lhs: Element?, line: UInt = #line) {
        XCTAssertNotNil(lhs?.file, line: line)
        XCTAssertNotNil(file)
        guard let lhs = lhs?.file as? ElementProxy, let file = file as? ElementProxy else {
            XCTFail("There was no proxy for the element", line: line)
            return
        }
        XCTAssert(lhs.managed === file.managed, line: line)
    }

    private func getProtocolString() -> String {
        return """
protocol A: B {
    init(i: Int)
    var a: A { get set }
    func b<T>(b: T) -> String
}
"""
    }
}
