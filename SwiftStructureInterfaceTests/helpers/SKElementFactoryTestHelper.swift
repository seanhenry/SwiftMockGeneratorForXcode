@testable import SwiftStructureInterface

class SKElementFactoryTestHelper {

    static func build(from string: String) -> FileImpl? {
        return SKElementFactory().build(from: string) as? FileImpl
    }

    static func build(fromPath path: String) -> FileImpl? {
        return SKElementFactory().build(fromPath: path) as? FileImpl
    }
}
