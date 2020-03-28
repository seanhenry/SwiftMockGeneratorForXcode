import Foundation
import XcodeKit
import SwiftyKit
import MockGenerator
import AppKit

open class BaseCommand: NSObject, XCSourceEditorCommand {

    open var templateName: String {
        fatalError("override me")
    }

    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> ()) {
        perform(with: invocation as SourceEditorCommandInvocation, completionHandler: completionHandler)
    }

    func perform(with invocation: SourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> ()) {
        invocation.cancellationHandler = {
            completionHandler(nil)
        }
        do {
            let projectURL = try getProjectURLOnMainThread()
            _ = projectURL.startAccessingSecurityScopedResource()
            defer { projectURL.stopAccessingSecurityScopedResource() }
            let instructions = try Generator(
                projectURL: projectURL,
                templateName: templateName,
                useTabsForIndentation: invocation.sourceTextBuffer.usesTabsForIndentation,
                indentationWidth: invocation.sourceTextBuffer.indentationWidth,
                trackLines: { [weak self] in self?.track(lineCount: $0) }
            )
                .execute(buffer: TextBufferImpl(invocation.sourceTextBuffer))
            let selections = NSMutableArray()
            try instructions.forEach { instruction in
                try instruction.execute(lines: invocation.sourceTextBuffer.lines, selections: selections)
            }
            transformSelections(in: invocation.sourceTextBuffer.selections, selections)
            completionHandler(nil)
        } catch {
            track(error)
            completionHandler(error)
        }
    }

    private func transformSelections(in selections: NSMutableArray, _ toTransform: NSMutableArray) {
        selections.removeAllObjects()
        toTransform
            .compactMap { $0 as? SelectionRange }
            .map { $0.toXCSourceTextRange() }
            .forEach { selections.add($0) }
    }

    private func getProjectURLOnMainThread() throws -> URL {
        if Thread.isMainThread {
            return try getProjectURL()
        }
        return try DispatchQueue.main.sync {
            return try getProjectURL()
        }
    }

    private func getProjectURL() throws -> URL {
        let url = try ProjectFinder(
            projectFinder: XcodeProjectPathFinder(),
            preferences: Preferences()
        )
            .getProjectPath()
        return try BookmarkedURL.bookmarkedURL(url: url)
    }

    private func track(lineCount: Int) {
        let tracker = GoogleAnalyticsTracker()
        tracker.track(category: templateName, action: "generated", value: lineCount)
    }

    private func track(_ error: Error?) {
        let tracker = GoogleAnalyticsTracker()
        if let error = error {
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            tracker.track(category: templateName, action: "\(version)_\(error.localizedDescription)")
        }
    }
}

extension SelectionRange {

    func toXCSourceTextRange() -> XCSourceTextRange {
        return XCSourceTextRange(
            start: XCSourceTextPosition(line: start.line, column: start.column),
            end: XCSourceTextPosition(line: end.line, column: end.column)
        )
    }
}

