import Source

class GetterSetterKeywordBlockParser: Parser<GetterSetterKeywordBlock> {

    override func parse(offset: Int64) -> GetterSetterKeywordBlock {
        let offset = convert(getCurrentStartLocation())!
        var isWritable = false
        advance(if: .leftBrace)
        parseGetSet(isWritable: &isWritable)
        parseGetSet(isWritable: &isWritable)
        advance(if: .rightBrace)
        return createElement(offset: offset) { length, text in
            return SwiftGetterSetterKeywordBlock(
                text: text,
                children: [],
                offset: offset,
                length: length,
                isWritable: isWritable)
        } ?? SwiftGetterSetterKeywordBlock.errorGetterSetterKeywordBlock
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
