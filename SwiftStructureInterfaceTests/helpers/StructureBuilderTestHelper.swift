import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTestHelper {

    static func build(from string: String) -> SwiftFile? {
        let dictionary = Structure(file: File(contents: string)).dictionary
        return StructureBuilder(data: dictionary, text: string).build() as? SwiftFile
    }

    static func build(fromPath path: String) -> SwiftFile? {
        let file = File(path: path)!
        let dictionary = Structure(file: file).dictionary
        return StructureBuilder(data: dictionary, text: file.contents).build() as? SwiftFile
    }
}
