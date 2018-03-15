import Foundation
@testable import MockGenerator

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {

    private static var tracker = GoogleAnalyticsTracker()

    func generateMock(fromFileContents contents: String, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        let completion: ([String]?, Error?) -> () = { lines, error in
            self.track(lines, error)
            reply(lines, error)
        }
        let (projectURL, error) = ProjectFinder(projectFinder: XcodeProjectPathFinder(), preferences: Preferences()).getProjectPath()
        if let projectURL = projectURL {
            generateMock(projectURL: projectURL, contents: contents, line: line, column: column, completion: completion)
        } else {
            completion(nil, error)
        }
    }

    private func generateMock(projectURL: URL, contents: String, line: Int, column: Int, completion: ([String]?, Error?) -> Void) {
        let (lines, error) = Generator.generateMock(fromFileContents: contents,
            projectURL: projectURL,
            line: line,
            column: column)
        completion(lines, error)
    }

    private func track(_ lines: [String]?, _ error: Error?) {
        if let error = error {
            MockGeneratorXPC.tracker.track(action: error.localizedDescription)
        } else if let lines = lines {
            MockGeneratorXPC.tracker.track(action: "generated", value: lines.count)
        }
    }
}
