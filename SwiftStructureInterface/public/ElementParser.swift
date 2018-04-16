public class ElementParser {

    private init() {}

    public static func parseType(_ string: String) -> Type {
        return FileParser(fileContents: string).parseType()
    }
}
