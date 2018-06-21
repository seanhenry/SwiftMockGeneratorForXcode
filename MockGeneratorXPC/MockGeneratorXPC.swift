import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, templateName: String, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let (lines, error) = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column,
            templateName: templateName)
        reply(lines, error)
    }

    #if DEBUG
    func crash() {
        fatalError()
    }
    #endif
}
