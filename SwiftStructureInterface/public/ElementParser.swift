public class ElementParser {

    private init() {}

    public static func parseType(_ string: String) -> Type {
        return FileParser(fileContents: string).parseType()
    }

    public static func parseFile(_ string: String) -> File {
        return FileParser(fileContents: string).parse()
    }
}
