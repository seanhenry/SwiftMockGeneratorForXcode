import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let (lines, error) = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column)
        reply(lines, error)
    }
}
