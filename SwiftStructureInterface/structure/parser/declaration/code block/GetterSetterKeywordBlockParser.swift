import Source

class GetterSetterKeywordBlockParser: Parser<GetterSetterKeywordBlock> {

    override func parse(start: LineColumn) -> GetterSetterKeywordBlock {
        return GetterSetterKeywordBlockImpl(children: [
            try? parsePunctuation(.leftBrace),
            parseWhitespace(),
            parseGetSet(),
            parseGetSet(),
            try? parsePunctuation(.rightBrace),
        ])
    }

    private func parseGetSet() -> GetterSetterKeywordClause {
        return GetterSetterKeywordClauseImpl(children: [
            parseAttributesAndWhitespace(),
            parseMutationModifierAndWhitespace(),
            parseKeywordAndWhitespace()
        ])
    }

    private func parseKeywordAndWhitespace() -> [Element]? {
        if isNext([.set, .get]) {
            return [parseKeyword(), parseWhitespace()]
        }
        return nil
    }

    private func parseAttributesAndWhitespace() -> [Element?] {
        if isNext(.at) {
            return [parseAttributes(), parseWhitespace()]
        }
        return [parseAttributes()]
    }

    private func parseMutationModifierAndWhitespace() -> [Element?] {
        if isNext([.nonmutating, .mutating]) {
            return [parseMutationModifier(), parseWhitespace()]
        }
        return [parseMutationModifier()]
    }
}
