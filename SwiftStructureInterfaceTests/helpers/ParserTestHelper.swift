@testable import SwiftStructureInterface

class ParserTestHelper {

    static func parseFile(from string: String) throws -> File {
        return try ElementParser.parseFile(string)
    }

    static func parseFile(fromPath path: String) throws -> File {
        return try ElementParser.parseFile(at: path)
    }
}
