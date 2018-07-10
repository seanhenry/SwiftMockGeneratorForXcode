import Foundation
import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    func generateMock(from model: XPCMockGeneratorModel, withReply reply: @escaping (XPCBufferInstructions?, Error?) -> ()) {
        let (instructions, error) = Generator(fromFileContents: model.contents,
                projectURL: model.projectURL,
                line: model.line,
                column: model.column,
                templateName: model.templateName,
                useTabsForIndentation: model.usesTabsForIndentation,
                indentationWidth: model.indentationWidth
        ).generateMock()
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
