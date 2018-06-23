import XcodeKit

protocol SourceEditorCommandInvocation: class {
    var commandIdentifier: String { get }
    var sourceTextBuffer: SourceTextBuffer { get }
    var cancellationHandler: () -> () { get set }
}

protocol SourceTextBuffer: class {
    var completeBuffer: String { get set }
    var selections: NSMutableArray { get }
    var lines: NSMutableArray { get }
    var usesTabsForIndentation: Bool { get }
    var indentationWidth: Int { get }
}

extension XCSourceEditorCommandInvocation: SourceEditorCommandInvocation {
    
    var sourceTextBuffer: SourceTextBuffer {
        return buffer as SourceTextBuffer
    }
}

extension XCSourceTextBuffer: SourceTextBuffer {}
