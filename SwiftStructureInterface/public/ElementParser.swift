public class ElementParser {

    private init() {}

    public static func parseType(_ string: String) -> Type {
        let type = FileParser(fileContents: string).parseType()
        return ManagedElementVisitor.wrap(type) as! Type
    }

    public static func parseFile(_ string: String) -> File {
        let file = FileParser(fileContents: string).parse()
        return ManagedElementVisitor.wrap(file) as! File
    }

    public static func parseFile(at path: String) -> File? {
        let file = FileParser(filePath: path)?.parse()
        return file.flatMap { ManagedElementVisitor.wrap($0) as? File }
    }
}
