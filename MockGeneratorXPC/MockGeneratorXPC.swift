import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    func generateMock(fromFileContents contents: String,
                      projectURL: URL,
                      line: Int,
                      column: Int,
                      templateName: String,
                      withReply reply: @escaping (XPCBufferInstructions?, Error?) -> Void) {
        let (instructions, error) = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column,
            templateName: templateName)
        let transformed = instructions.flatMap {
            XPCBufferInstructions(deleteIndex: $0.deleteIndex,
                    deleteLength: $0.deleteLength,
                    insertIndex: $0.insertIndex,
                    linesToInsert: $0.linesToInsert)
        }
        reply(transformed, error)
    }

    #if DEBUG
    func crash() {
        fatalError()
    }
    #endif
}
