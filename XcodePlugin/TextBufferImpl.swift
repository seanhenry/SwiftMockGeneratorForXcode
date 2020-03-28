import Foundation
import XcodeKit
import SwiftyKit


public class TextBufferImpl: NSObject, TextBuffer {

  private let textBuffer: SourceTextBuffer

  public init(_ textBuffer: SourceTextBuffer) {
    self.textBuffer = textBuffer
  }

  public var url: URL? {
    return nil
  }

  public var contentUTI: String {
    return textBuffer.contentUTI
  }

  public var tabWidth: Int {
    return textBuffer.tabWidth
  }

  public var indentationWidth: Int {
    return textBuffer.indentationWidth
  }

  public var usesTabsForIndentation: Bool {
    return textBuffer.usesTabsForIndentation
  }

  public var lines: [String] {
    return textBuffer.lines as! [String]
  }

  public var selectionRange: [SelectionRange] {
    return textBuffer.selections
      .compactMap { $0 as? XCSourceTextRange }
      .map { selection in
        SelectionRangeFactory.create(selection.start.line, selection.start.column, selection.end.line, selection.end.column)
      }
  }

  public var completeBuffer: String {
    set { textBuffer.completeBuffer = newValue }
    get { return textBuffer.completeBuffer }
  }
}
