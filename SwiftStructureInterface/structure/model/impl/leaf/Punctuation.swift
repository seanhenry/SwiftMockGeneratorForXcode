public class Punctuation {

    static let arrow = LeafNodeImpl(text: "->")
    static let colon = LeafNodeImpl(text: ":")
    static let comma = LeafNodeImpl(text: ",")
    static let dot = LeafNodeImpl(text: ".")
    static let semicolon = LeafNodeImpl(text: ";")
    static let at = LeafNodeImpl(text: "@")
    static let hash = LeafNodeImpl(text: "#")
    static let backslash = LeafNodeImpl(text: "\\")
    static let leftParen = LeafNodeImpl(text: "(")
    static let rightParen = LeafNodeImpl(text: ")")
    static let leftBrace = LeafNodeImpl(text: "{")
    static let rightBrace = LeafNodeImpl(text: "}")
    static let leftSquare = LeafNodeImpl(text: "[")
    static let rightSquare = LeafNodeImpl(text: "]")
    static let leftChevron = LeafNodeImpl(text: "<")
    static let rightChevron = LeafNodeImpl(text: ">")
    static let prefixAmp = LeafNodeImpl(text: "&")
    static let underscore = LeafNodeImpl(text: "_")

    static let punctuation: [String: LeafNodeImpl] = [
        "arrow": arrow,
        "colon": colon,
        "comma": comma,
        "dot": dot,
        "semicolon": semicolon,
        "at": at,
        "hash": hash,
        "backslash": backslash,
        "leftParen": leftParen,
        "rightParen": rightParen,
        "leftBrace": leftBrace,
        "rightBrace": rightBrace,
        "leftSquare": leftSquare,
        "rightSquare": rightSquare,
        "leftChevron": leftChevron,
        "rightChevron": rightChevron,
        "prefixAmp": prefixAmp,
        "underscore": underscore,
    ]

    private init() {}
}
