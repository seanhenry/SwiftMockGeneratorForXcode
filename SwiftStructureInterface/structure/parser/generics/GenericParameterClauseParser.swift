class GenericParameterClauseParser: Parser<GenericParameterClause> {

    override func parse(start: LineColumn) -> GenericParameterClause {
        if isNext("<") {
            advanceOperator("<")
            _ = parseGenericParameterList()
            parseGenericClosingBracket()
        } else {
            return SwiftGenericParameterClause.errorGenericParameterClause
        }
        return createElement(start: start) { offset, length, text in
            return SwiftGenericParameterClause(
                text: text,
                children: [],
                offset: offset,
                length: length)
        } ?? SwiftGenericParameterClause.errorGenericParameterClause
    }

    private func parseGenericParameterList() -> String {
        var parameterList = [String]()
        parameterList.append(parseGenericParameter())
        while isNext(.comma) {
            advance()
            parameterList.append(parseGenericParameter())
        }
        return parameterList.joined(separator: ", ")
    }

    private func parseGenericParameter() -> String {
        var parameter = ""
        tryToAppendIdentifier(to: &parameter)
        tryToAppend(.colon, value: ": ", to: &parameter)
        tryToAppendType(to: &parameter)
        return parameter
    }

    private func parseGenericClosingBracket() {
        if isNext(">") {
            advanceOperator(">")
        }
    }
}
