import Lexer

extension NamedIdentifier {

    var text: String {
        switch self {
        case .backtickedName(let escaped): return escaped
        case .name(let name): return name
        case .wildcard: return "_"
        }
    }
}
