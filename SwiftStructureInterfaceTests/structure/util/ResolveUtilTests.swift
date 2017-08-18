import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class ResolveUtilTests: XCTestCase {

    var util: ResolveUtil!
    let resolveFile = NSTemporaryDirectory() + "resolve.swift"
    let resolvedFile = NSTemporaryDirectory() + "resolved.swift"

    override func setUp() {
        super.setUp()
        util = ResolveUtil()
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
        let swiftFile = File(path: resolveFile)!
        let structure = Structure(file: swiftFile)
        let element = StructureBuilder(data: structure.dictionary, text: swiftFile.contents).build()
        let reference = (element.children[0] as! SwiftTypeElement).inheritedTypes[0]
        XCTAssertEqual(util.resolve(reference)?.name, "ResolvedProtocol")
        XCTAssertEqual(util.resolve(reference)?.children[0].name, "method")
    }

    // MARK: - Helpers

    private func writeResolveClassesToFile() {
        try! getResolveClassString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolveFile))
        try! getResolvedProtocolString().data(using: .utf8)!
            .write(to: URL(fileURLWithPath: resolvedFile))
    }

    private func getResolveClassString() -> String {
        return "class ResolveTest: ResolvedProtocol { }"
    }

    private func getResolvedProtocolString() -> String {
        return "protocol ResolvedProtocol { " + "\n" +
            "" + "\n" +
            "  func method() {}" + "/n" +
            "}"
    }
}
