import XCTest
import SwiftStructureInterface
@testable import MockGenerator

class TypeDeclarationTransformingVisitorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        ResolveUtil.sameFileCursorInfoRequest = SKCursorInfoRequest(files: [])
        ResolveUtil.cursorInfoRequest = SKCursorInfoRequest(files: [])
    }

    override func tearDown() {
        ResolveUtil.sameFileCursorInfoRequest = nil
        ResolveUtil.cursorInfoRequest = nil
        super.tearDown()
    }

    func test_shouldTransformEmptyProtocol() {
        let p = SKElementFactoryTestHelper.build(from: "protocol P {} class Mock: P {}")!.children[1] as! TypeDeclaration
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)[0]
        XCTAssertEqual(transformed.properties.isEmpty, true)
        XCTAssertEqual(transformed.initializers.isEmpty, true)
        XCTAssertEqual(transformed.methods.isEmpty, true)
    }

    func test_shouldTransformProtocol() {
        let p = SKElementFactoryTestHelper.build(from: getProtocolString())!.children[1] as! TypeDeclaration
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)[0]
        XCTAssertEqual(transformed.properties.count, 1)
        XCTAssertEqual(transformed.initializers.count, 1)
        XCTAssertEqual(transformed.methods.count, 1)
    }

    func test_shouldTransformAndResolveMultipleProtocols() {
        let p = SKElementFactoryTestHelper.build(from: getMultipleProtocolString())!.children[2] as! TypeDeclaration
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)[1]
        XCTAssertEqual(transformed.properties.count, 1)
        XCTAssertEqual(transformed.initializers.count, 1)
        XCTAssertEqual(transformed.methods.count, 1)
    }

    func test_shouldIgnoreClassTypes() {
        let p = SKElementFactoryTestHelper.build(from: "class A {} class B: A {}")!.children[1] as! TypeDeclaration
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)
        XCTAssert(transformed.isEmpty)
    }

    func test_shouldIgnoreUnresolvableTypes() {
        let p = SKElementFactoryTestHelper.build(from: "class A: Nonexistent {}")!.children[0] as! TypeDeclaration
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)
        XCTAssert(transformed.isEmpty)
    }

    func test_shouldIgnoreNonClassMocks() {
        let p = ElementParser.parseType("Type")
        let transformed = TypeDeclarationTransformingVisitor.transformMock(p)
        XCTAssert(transformed.isEmpty)
    }

    private func getProtocolString() -> String {
        return """
        protocol P {
          init()
          var p: Int { get }
          func m()
        }
        class Mock: P {
        }
        """
    }

    private func getMultipleProtocolString() -> String {
        return """
        protocol A {
          init()
          var p: Int { get }
          func m()
        }
        protocol P {
          init()
          var p: Int { get }
          func m()
        }
        class Mock: P, A {
        }
        """
    }
}
