@testable import SwiftStructureInterface

class SKElementFactoryTestHelper {

    static func build(from string: String) -> File? {
        return ElementParser.parseFile(string)
    }

    static func build(fromPath path: String) -> File? {
        return ElementParser.parseFile(at: path)
    }
}
