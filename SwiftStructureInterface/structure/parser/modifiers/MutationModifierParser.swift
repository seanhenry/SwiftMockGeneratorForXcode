import Lexer

class MutationModifierParser: Parser<MutationModifier> {

    static let modifiers: [(Token.Kind, String)] = [
        (.mutating, "mutating"),
        (.nonmutating, "nonmutating"),
    ]

    override func parse(start: LineColumn) -> MutationModifier {
        if isNext([.mutating, .nonmutating]) {
            return MutationModifierImpl(children: [
                parseKeyword()
            ])
        }
        return MutationModifierImpl.emptyMutationModifier
    }
}
