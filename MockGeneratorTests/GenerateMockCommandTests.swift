import XCTest
import MockGenerator
import AST
import SwiftyKit
import TestHelper

class GenerateMockCommandTests: XCTestCase {

    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: InsertMockCommandTests.self).resourcePath! + "/TestProject"
    var ioSpy: IOSpy!
    var invokedError: String?

    override func setUp() {
        super.setUp()
        ioSpy = IOSpy()
        ioSpy.stubbedCreateFileResult = true
    }

    func testGeneratesSimpleMock() throws {
        try execute()
        XCTAssertEqual(ioSpy.invokedCreateFileParameters?.path, "out/PrefixSimpleProtocolPostfix.swift")
        StringCompareTestHelper.assertEqualStrings(fileContents, """
        // COMMENT
        import A
        import B
        @testable import C
        @testable import D

        class PrefixSimpleProtocolPostfix: SimpleProtocol {

            var invokedSimpleMethod = false
            var invokedSimpleMethodCount = 0

            func simpleMethod() {
                invokedSimpleMethod = true
                invokedSimpleMethodCount += 1
            }
        }

        """)
    }

    func testThrowsErrorWhenFileCannotBeWritten() throws {
        ioSpy.stubbedCreateFileResult = false
        XCTAssertThrowsError(try execute())
        XCTAssertEqual(invokedError, "Could not write to the file at out/PrefixSimpleProtocolPostfix.swift")
    }

    func testThrowsErrorWhenCannotMockClass() throws {
        XCTAssertThrowsError(try execute(targetName: "Cannot/Be-Parsed"))
        XCTAssertEqual(invokedError, "Could not build class declaration for PrefixCannot/Be-ParsedPostfix")
    }

    private var fileContents: String? {
        guard let data = ioSpy.invokedCreateFileParameters?.data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    private func execute(targetName: String = "SimpleProtocol") throws {
        do {
            try GenerateMockCommand(
                targetName: targetName,
                importModules: ["A", "B"],
                testableImportModules: ["C", "D"],
                templateName: "spy",
                mockPrefix: "Prefix",
                mockPostfix: "Postfix",
                outDirectory: "out",
                generationComment: "// COMMENT",
                io: ioSpy
            ).execute()
        } catch {
            invokedError = error.localizedDescription
            throw error
        }
    }

}
