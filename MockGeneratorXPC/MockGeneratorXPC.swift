import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    private static var tracker = GoogleAnalyticsTracker()

    func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let (lines, error) = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column)
        track(lines, error)
        reply(lines, error)
    }

    private func track(_ lines: [String]?, _ error: Error?) {
        if let error = error {
            MockGeneratorXPC.tracker.track(action: error.localizedDescription)
        } else if let lines = lines {
            MockGeneratorXPC.tracker.track(action: "generated", value: lines.count)
        }
    }
}
