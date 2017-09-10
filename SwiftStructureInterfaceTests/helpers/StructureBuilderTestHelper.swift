import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTestHelper {

    static func build(from string: String) -> SwiftFile? {
        let dictionary = Structure(file: File(contents: string)).dictionary
        return StructureBuilder(data: dictionary, fileText: string).build() as? SwiftFile
    }

    static func build(fromPath path: String) -> SwiftFile? {
        let file = File(path: path)!
        let dictionary = Structure(file: file).dictionary
        return StructureBuilder(data: dictionary, fileText: file.contents).build() as? SwiftFile
    }
}
