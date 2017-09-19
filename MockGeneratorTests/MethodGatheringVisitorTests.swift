import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface
@testable import MockGenerator

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!
    var environment: JavaEnvironment!

    override func setUp() {
        super.setUp()
        environment = JavaEnvironment.shared
        visitor = MethodGatheringVisitor(environment: environment)
    }

    override func tearDown() {
        visitor = nil
        environment = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldGetAllMethodsFromProtocol() {
        getMethodProtocol().accept(RecursiveElementVisitor(visitor: visitor))
        XCTAssertEqual(visitor.methods.map { $0.name }, ["method", "method2", "method3"])
        XCTAssertEqual(visitor.methods.map { $0.signature }, ["func method()", "func method2(label name: Type) -> String", "func method3(label name: Type, param: OtherType) -> String"])
        XCTAssertEqual(visitor.methods.map { $0.parameters }, ["", "label name: Type", "label name: Type, param: OtherType"])
    }

    func test_visit_shouldGetAllPropertiesFromProtocol() {
        getPropertyProtocol().accept(RecursiveElementVisitor(visitor: visitor))
        XCTAssertEqual(visitor.properties.map { $0.name }, ["prop1", "prop2", "prop3"])
        XCTAssertEqual(visitor.properties.map { $0.type }, ["Int", "String!", "NSObject?"])
        XCTAssertEqual(visitor.properties.map { $0.signature }, ["var prop1: Int { get set }", "var prop2: String! { get }", "weak var prop3: NSObject? { set get }"])
    }

    // MARK: - Helpers

    private func getMethodProtocol() -> Element {
        let file = SKElementFactoryTestHelper.build(from: getMethodProtocolString())!
        return file.children[0]
    }

    private func getMethodProtocolString() -> String {
        return """
        protocol TestProtocol {
            func method()
            func method2(label name: Type) -> String
            func method3(label name: Type, param: OtherType) -> String
        }
        """
    }

    private func getPropertyProtocol() -> Element {
        let file = SKElementFactoryTestHelper.build(from: getPropertyProtocolString())!
        return file.children[0]
    }

    private func getPropertyProtocolString() -> String {
        return """
            protocol TestProtocol {
              var prop1: Int { get set }
              var prop2: String! { get }
              weak var prop3: NSObject? { set get }
            }
        """
    }
}
