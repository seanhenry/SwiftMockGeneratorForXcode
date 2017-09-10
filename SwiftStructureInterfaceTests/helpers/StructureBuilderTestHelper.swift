@testable import SwiftStructureInterface

class StructureBuilderTestHelper {

    static func build(from string: String) -> SwiftFile? {
        return StructureBuilder().build(from: string) as? SwiftFile
    }

    static func build(fromPath path: String) -> SwiftFile? {
        return StructureBuilder().build(fromPath: path) as? SwiftFile
    }
}
