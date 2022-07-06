import XCTest
import Resolver
import UseCases
import Parser
import AST
import TestHelper
import SwiftyKit
@testable import MockGenerator

class TypeDeclarationTransformingVisitorTests: XCTestCase {

    var resolver: Resolver!

    override func setUp() {
        super.setUp()
        resolver = ResolverFactory.createResolver(filePaths: [])
    }

    override func tearDown() {
        resolver = nil
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

    func test_shouldIgnoreNonClassMocks() throws {
        let type = try ParserTestHelper.parseFile(from: "protocol Mock: A {} protocol A {}")
            .typeDeclarations[0]
        let transformed = TypeDeclarationTransformingVisitor.transformMock(type, resolver: resolver)
        XCTAssert(transformed.protocols.isEmpty)
        XCTAssertNil(transformed.inheritedClass)
    }

    private func transformProtocols(_ string: String) -> [UseCases.`Protocol`] {
        let p = try! ParserTestHelper.parseFile(from: string).typeDeclarations[0]
        let protocols = TypeDeclarationTransformingVisitor.transformMock(p, resolver: resolver).protocols
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

    func test_shouldTransformEmptyClass() {
        let transformed = transform("class Mock: C {} class C {}")
        let inherited = transformed.inheritedClass
        XCTAssertNotNil(inherited)
        XCTAssertEqual(inherited?.properties.isEmpty, true)
        XCTAssertEqual(inherited?.initializers.isEmpty, true)
        XCTAssertEqual(inherited?.methods.isEmpty, true)
        XCTAssertNil(inherited?.inheritedClass)
    }

    func test_shouldTransformClass() {
        let transformed = transform(getClassString())
        let inherited = transformed.inheritedClass
        XCTAssertNotNil(inherited)
        XCTAssertEqual(inherited?.properties.count, 1)
        XCTAssertEqual(inherited?.initializers.count, 1)
        XCTAssertEqual(inherited?.methods.count, 1)
        XCTAssertNil(inherited?.inheritedClass)
    }

    func test_shouldTransformClassWithInheritedClass() {
        let transformed = transform(getInheritanceClassString())
        let inherited = transformed.inheritedClass
        XCTAssertNotNil(inherited)
        XCTAssertNotNil(inherited?.inheritedClass)
    }

    func test_shouldIgnoreNSObjectAndReplaceItWithClassWithEmptyInitializer() {
        let transformed = transform("class Mock: NSObject {} class NSObject {}")
        let inherited = transformed.inheritedClass
        XCTAssertNotNil(inherited)
        XCTAssertEqual(inherited?.initializers.count, 1)
        XCTAssertEqual(inherited?.initializers[0].parametersList.count, 0)
        XCTAssertEqual(inherited?.initializers[0].isFailable, false)
        XCTAssertEqual(inherited?.initializers[0].`throws`, false)
    }

    func test_shouldIgnoreNSObjectProtocol() {
        let transformed = transform("class Mock: NSObjectProtocol {} protocol NSObjectProtocol {}")
        let protocols = transformed.protocols
        XCTAssertEqual(protocols.count, 0)
    }

    private func transform(_ string: String) -> MockClass {
        let mockClass = try! ParserTestHelper.parseFile(from: string).typeDeclarations[0]
        return TypeDeclarationTransformingVisitor.transformMock(mockClass, resolver: resolver)
    }

    private func getClassString() -> String {
        return """
        class Mock: C {
        }
        class C {
          init() {}
          func a() {}
          var a: A
        }
        """
    }

    private func getInheritanceClassString() -> String {
        return """
        class Mock: A {
        }
        class A: B {
        }
        class B {
        }
        """
    }
}
