import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    private static var tracker = GoogleAnalyticsTracker()

    func generateMock(fromFileContents contents: String, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let (projectURL, error) = ProjectFinder(projectFinder: XcodeProjectPathFinder(), preferences: Preferences()).getProjectPath()
        if let projectURL = projectURL {
            generateMock(projectURL: projectURL, contents: contents, line: line, column: column, reply: reply)
        } else {
            track(error)
            reply(nil, error)
        }
    }

    private func generateMock(projectURL: URL, contents: String, line: Int, column: Int, reply: ([String]?, Error?) -> Void) {
        let mock = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column)
        track(mock.1)
        reply(mock.0, mock.1)
    }

    private func track(_ error: Error?) {
        if let error = error {
            MockGeneratorXPC.tracker.track(action: error.localizedDescription)
        } else {
            MockGeneratorXPC.tracker.track(action: "generated")
        }
    }
}
