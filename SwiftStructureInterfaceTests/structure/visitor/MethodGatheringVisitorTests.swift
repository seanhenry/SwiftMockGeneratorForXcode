import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!

    override func setUp() {
        super.setUp()
        visitor = MethodGatheringVisitor()
    }

    override func tearDown() {
        visitor = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldGetAllMethodNamesFromProtocol() {
        getProtocol().accept(RecursiveElementVisitor(visitor: visitor))
        XCTAssertEqual(visitor.methodNames, ["method", "method2"])
    }

    // MARK: - Helpers

    private func getProtocol() -> Element {
        let file = StructureBuilderTestHelper.build(from: getProtocolString())!
        return file.children[0]
    }

    private func getProtocolString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func method()" + "\n" +
            "  func method2()" + "\n" +
            "}"
    }
}
