@testable import SwiftStructureInterface

class SKElementFactoryTestHelper {

    static func build(from string: String) -> File? {
        return SKElementFactory().build(from: string) as? File
    }

    static func build(fromPath path: String) -> File? {
        return SKElementFactory().build(fromPath: path) as? File
    }
}
