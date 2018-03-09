import XCTest
@testable import SwiftStructureInterface

class DeclarationsParserTests: XCTestCase {

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        let parser = FileParser(fileContents: "publi protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 6)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 18)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithMethods() {
        let parser = FileParser(fileContents: getProtocolWithMethods())
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, getProtocolWithMethods())
        XCTAssertEqual(`protocol`?.name, "ProtocolWithMethod")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, Int64(getProtocolWithMethods().utf8.count))
        let function1 = `protocol`?.children[0] as! SwiftMethodElement
        XCTAssertEqual(function1.text, getFunction())
        XCTAssertEqual(function1.offset, 34)
        XCTAssertEqual(function1.length, Int64(getFunction().utf8.count))
    }

    // MARK: - Helpers

    func getProtocolWithMethods() -> String {
        return """
        protocol ProtocolWithMethod() {
          \(getFunction())
        }
        """
    }

    func getFunction() -> String {
        return """
        @a public mutating func aFunc(_ a: A, b c: D<E>) throws -> [String: Int]?
        """
    }
}
