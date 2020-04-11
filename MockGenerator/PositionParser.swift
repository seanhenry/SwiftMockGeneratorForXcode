import Parser
import AST
import SwiftyKit
import Algorithms
import Foundation

public class PositionParser: Parser {

    public init() {}
    public func parseFile(_ string: String, url: URL?) throws -> AST.File {
        let file = try ParserImpl().parseFile(string, url: url)
        PositionVisitor.calculate(file)
        return file
    }

    public func parseFile(at path: String) throws -> AST.File {
        let file = try ParserImpl().parseFile(at: path)
        PositionVisitor.calculate(file)
        return file
    }

    public func parseType(_ string: String) throws -> Type {
        return try ParserImpl().parseType(string)
    }

    public func parseWhitespace(_ string: String) throws -> Whitespace {
        return try ParserImpl().parseWhitespace(string)
    }

    public func parseHorizontalWhitespaceItem(_ string: String) throws -> HorizontalWhitespaceItem {
        return try ParserImpl().parseHorizontalWhitespaceItem(string)
    }

    public func parseLineBreaks(_ string: String) throws -> [LineBreak] {
        return try ParserImpl().parseLineBreaks(string)
    }
}
