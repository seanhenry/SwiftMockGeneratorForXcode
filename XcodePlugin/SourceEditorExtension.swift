import Foundation
import XcodeKit
import SwiftyKit
import SwiftyServiceImpl
import ASTSerialize
import Parser
import MockGenerator

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

  var connection: NSXPCConnection!

  func extensionDidFinishLaunching() {
    makeService = { SwiftyServiceImpl() }
    makeDeserializer = { ASTDeserializer() }
    parserFactory = ParserFactory { PositionParser() }
  }
}
