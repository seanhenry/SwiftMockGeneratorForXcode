import Source

// TODO: Parse setter-name (class only)

class GetterSetterKeywordBlockParser: Parser<GetterSetterKeywordBlock> {

    override func parse() -> GetterSetterKeywordBlock {
        let offset = convert(getCurrentStartLocation())!
        var isWritable = false
        advance(if: .leftBrace)
        parseGetSet(isWritable: &isWritable)
        parseGetSet(isWritable: &isWritable)
        advance(if: .rightBrace)
        let length = convert(getPreviousEndLocation())! - offset
        return SwiftGetterSetterKeywordBlock(
            text: getString(offset: offset, length: length)!,
            children: [],
            offset: offset,
            length: length,
            isWritable: isWritable)
    }

    private func parseGetSet(isWritable: inout Bool) {
        _ = parseAttributes()
        _ = parseMutationModifiers()
        if isNext(.set) {
            isWritable = true
        }
        advance(if: [.get, .set])
    }
}
