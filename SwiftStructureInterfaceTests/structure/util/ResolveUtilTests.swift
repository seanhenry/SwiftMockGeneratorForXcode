import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class ResolveUtilTests: XCTestCase {

    var util: ResolveUtil!
    var resolveFile: String!
    var resolvedFile: String!

    override func setUp() {
        super.setUp()
        util = ResolveUtil()
        // SourceKit caches files
        resolveFile = NSTemporaryDirectory() + UUID().uuidString + "_resolve.swift"
        resolvedFile = NSTemporaryDirectory() + UUID().uuidString + "_resolved.swift"
        ResolveUtil.files = [resolveFile, resolvedFile]
    }

    override func tearDown() {
        ResolveUtil.files = []
        util = nil
        super.tearDown()
    }

    // MARK: - resolve

    func test_resolve_shouldResolveSwiftTypeElement() {
        writeResolveClassesToFile()
        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
        let reference = (file.children[0] as! SwiftTypeElement).inheritedTypes[0]
        let resolved = util.resolve(reference) as? NamedElement
        XCTAssertEqual(resolved?.name, "ResolveTest")
        let method = resolved?.namedChild(at: 0)
        XCTAssertEqual(method?.name, "method")
    }

    func test_resolve_shouldResolveElementWithUTF16Characters() {
        writeUTF16ResolveClassesToFile()
        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
        let reference = (file.children[0] as! SwiftTypeElement).inheritedTypes[0]
        let resolved = ResolveUtil().resolve(reference) as? NamedElement
        XCTAssertEqual(resolved?.name, "Resolve💐Test")
        let method = resolved?.namedChild(at: 0)
        XCTAssertEqual(method?.name, "method💐")
    }

    // MARK: - Helpers

    private func writeResolveClassesToFile() {
        try! getResolveClassString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolveFile))
        try! getResolvedProtocolString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolvedFile))
    }

    private func getResolveClassString() -> String {
        return "class MockResolveTest: ResolveTest { }"
    }

    private func getResolvedProtocolString() -> String {
        return "protocol ResolveTest { " + "\n" +
            "" + "\n" +
            "  func method() {}" + "\n" +
            "}"
    }

    private func writeUTF16ResolveClassesToFile() {
        try! getUTF16ResolveClassString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolveFile))
        try! getUTF16ResolvedProtocolString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolvedFile))
    }

    private func getUTF16ResolveClassString() -> String {
        return "class MockResolve💐Test: Resolve💐Test { }"
    }

    private func getUTF16ResolvedProtocolString() -> String {
        return "protocol Resolve💐Test { " + "\n" +
            "" + "\n" +
            "  func method💐() {}" + "\n" +
            "}"
    }
}
