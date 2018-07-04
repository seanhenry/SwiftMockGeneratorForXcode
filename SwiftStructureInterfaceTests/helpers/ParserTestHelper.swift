@testable import SwiftStructureInterface
import XCTest

class ParserTestHelper {

    static func parseFile(from string: String) throws -> File {
        return try ElementParser.parseFile(string)
    }

    static func parseFile(fromPath path: String) throws -> File {
        return try ElementParser.parseFile(at: path)
    }

    static func parseGenericParameterClause(_ text: String) throws -> GenericParameterClause {
        return try XCTestCase.createParser(text, GenericParameterClauseParser.self).parse()
    }

    static func parseType(_ text: String) throws -> Type {
        return try XCTestCase.createParser(text, TypeParser.self).parse()
    }

    static func parseTypealias(_ text: String) throws -> TypealiasDeclaration {
        return try XCTestCase.createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self).parse()
    }
}
