import XcodeKit

public protocol SourceEditorCommandInvocation: class {
    var commandIdentifier: String { get }
    var sourceTextBuffer: SourceTextBuffer { get }
    var cancellationHandler: () -> () { get set }
}

public protocol SourceTextBuffer: class {
    var contentUTI: String { get }
    var tabWidth: Int { get }
    var completeBuffer: String { get set }
    var selections: NSMutableArray { get }
    var lines: NSMutableArray { get }
    var usesTabsForIndentation: Bool { get }
    var indentationWidth: Int { get }
}

extension XCSourceEditorCommandInvocation: SourceEditorCommandInvocation {

    public var sourceTextBuffer: SourceTextBuffer {
        return buffer as SourceTextBuffer
    }
}

extension XCSourceTextBuffer: SourceTextBuffer {}
