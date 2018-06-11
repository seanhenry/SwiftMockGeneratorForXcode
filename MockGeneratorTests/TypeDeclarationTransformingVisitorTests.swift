import XCTest
import SwiftStructureInterface
import UseCases
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
        let protocols = transformProtocols("class Mock: P {} protocol P {}")
        let `protocol` = protocols[0]
        XCTAssert(`protocol`.properties.isEmpty)
        XCTAssert(`protocol`.initializers.isEmpty)
        XCTAssert(`protocol`.methods.isEmpty)
    }

    func test_shouldTransformProtocol() {
        let protocols = transformProtocols(getProtocolString())
        let `protocol` = protocols[0]
        XCTAssertEqual(`protocol`.properties.count, 1)
        XCTAssertEqual(`protocol`.initializers.count, 1)
        XCTAssertEqual(`protocol`.methods.count, 1)
    }

    func test_shouldTransformAndResolveMultipleProtocols() {
        let protocols = transformProtocols(getMultipleProtocolString())
        let `protocol` = protocols[1]
        XCTAssertEqual(`protocol`.properties.count, 1)
        XCTAssertEqual(`protocol`.initializers.count, 1)
        XCTAssertEqual(`protocol`.methods.count, 1)
    }

    func test_shouldTransformDeepProtocolInheritance() {
        let protocols = transformProtocols(getDeepProtocolString())
        XCTAssertEqual(protocols.count, 1)
        let innerProtocols = protocols[0].protocols
        XCTAssertEqual(innerProtocols.count, 1)
        let nextInnerProtocols = innerProtocols[0].protocols
        XCTAssertEqual(nextInnerProtocols.count, 1)
    }

    func test_shouldIgnoreClassTypes() {
        let protocols = transformProtocols("class B: A {} class A {}")
        XCTAssert(protocols.isEmpty)
    }

    func test_shouldIgnoreUnresolvableTypes() {
        let protocols = transformProtocols("class A: Nonexistent {}")
        XCTAssert(protocols.isEmpty)
    }

    func test_shouldIgnoreNonClassMocks() {
        let p = ElementParser.parseType("Type")
        let protocols = TypeDeclarationTransformingVisitor.transformMock(p).protocols
        XCTAssert(protocols.isEmpty)
    }

    private func transformProtocols(_ string: String) -> [UseCasesProtocol] {
        let p = SKElementFactoryTestHelper.build(from: string)!.typeDeclarations[0]
        let protocols = TypeDeclarationTransformingVisitor.transformMock(p).protocols
        return protocols
    }

    private func getProtocolString() -> String {
        return """
        class Mock: P {
        }
        protocol P {
          init()
          var p: Int { get }
          func m()
        }
        """
    }

    private func getMultipleProtocolString() -> String {
        return """
        class Mock: P, A {
        }
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
        """
    }

    private func getDeepProtocolString() -> String {
        return """
        class Mock: P {
        }
        protocol B {
        }
        protocol A: B {
        }
        protocol P: A {
        }
        """
    }
}
