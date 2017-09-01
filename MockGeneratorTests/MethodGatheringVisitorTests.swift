import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface
@testable import MockGenerator

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!
    var environment: JavaEnvironment!

    override func setUp() {
        super.setUp()
        environment = JavaEnvironment()
        visitor = MethodGatheringVisitor(environment: environment)
    }

    override func tearDown() {
        visitor = nil
        environment = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldGetAllMethodsFromProtocol() {
        getProtocol().accept(RecursiveElementVisitor(visitor: visitor))
        XCTAssertEqual(visitor.methods.map { $0.name }, ["method", "method2"])
        XCTAssertEqual(visitor.methods.map { $0.signature }, ["func method()", "func method2(label name: Type) -> String"])
    }

    // MARK: - Helpers

    private func getProtocol() -> Element {
        let file = StructureBuilderTestHelper.build(from: getProtocolString())!
        return file.children[0]
    }

    private func getProtocolString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func method()" + "\n" +
            "  func method2(label name: Type) -> String" + "\n" +
            "}"
    }
}
