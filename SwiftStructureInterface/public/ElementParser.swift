public class ElementParser {

    private init() {}

    public static func parseType(_ string: String) throws -> Type {
        let type = try FileParser(fileContents: string).parseType()
        return ManagedElementVisitor.wrap(type) as! Type
    }

    public static func parseFile(_ string: String) throws -> File {
        let file = try FileParser(fileContents: string).parse()
        return ManagedElementVisitor.wrap(file) as! File
    }

    public static func parseFile(at path: String) throws -> File {
        return try FileParser(filePath: path).parse()
    }
}
