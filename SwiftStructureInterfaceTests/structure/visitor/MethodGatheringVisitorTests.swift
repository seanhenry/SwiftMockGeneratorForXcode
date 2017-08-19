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
        let protocolElement = StructureBuilder(data: Structure(file: File(contents: getProtocolString())).dictionary, text: getProtocolString()).build()
        return protocolElement.children[0]
    }

    private func getProtocolString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func method()" + "\n" +
            "  func method2()" + "\n" +
            "}"
    }
}
