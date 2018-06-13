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
}
