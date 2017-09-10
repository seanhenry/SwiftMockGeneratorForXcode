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
        XCTAssertEqual(visitor.methods.map { $0.name }, ["method", "method2"])
        XCTAssertEqual(visitor.methods.map { $0.signature }, ["func method()", "func method2(label name: Type) -> String"])
    }

    func test_visit_shouldGetAllPropertiesFromProtocol() {
        getPropertyProtocol().accept(RecursiveElementVisitor(visitor: visitor))
        XCTAssertEqual(visitor.properties.map { $0.name }, ["prop1", "prop2", "prop3"])
        XCTAssertEqual(visitor.properties.map { $0.type }, ["Int", "String!", "NSObject?"])
        XCTAssertEqual(visitor.properties.map { $0.signature }, ["var prop1: Int { get set }", "var prop2: String! { get }", "weak var prop3: NSObject? { set get }"])
    }

    // MARK: - Helpers

    private func getMethodProtocol() -> Element {
        let file = StructureBuilderTestHelper.build(from: getMethodProtocolString())!
        return file.children[0]
    }

    private func getMethodProtocolString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func method()" + "\n" +
            "  func method2(label name: Type) -> String" + "\n" +
            "}"
    }

    private func getPropertyProtocol() -> Element {
        let file = StructureBuilderTestHelper.build(from: getPropertyProtocolString())!
        return file.children[0]
    }

    private func getPropertyProtocolString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  var prop1: Int { get set }" + "\n" +
            "  var prop2: String! { get }" + "\n" +
            "  weak var prop3: NSObject? { set get }" + "\n" +
            "}" + "\n" +
            "class Object {}"
    }
}
