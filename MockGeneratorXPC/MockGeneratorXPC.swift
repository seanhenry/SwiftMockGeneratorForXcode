import Foundation
import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {
    
    func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let mock = Generator.generateMock(fromFileContents: contents, projectURL: projectURL, line: line, column: column)
        reply(mock.0, mock.1)
    }
}
