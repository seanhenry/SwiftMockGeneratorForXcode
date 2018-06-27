@testable import SwiftStructureInterface

class SKElementFactoryTestHelper {

    static func build(from string: String) throws -> File {
        return try ElementParser.parseFile(string)
    }

    static func build(fromPath path: String) throws -> File {
        return try ElementParser.parseFile(at: path)
    }
}
