class GenericParameterClauseParser: Parser<GenericParameterClause> {

    override func parse() -> GenericParameterClause {
        let start = getCurrentStartLocation()
        if isNext("<") {
            advanceOperator("<")
            _ = parseGenericParameterList()
            parseGenericClosingBracket()
        } else {
            return SwiftGenericParameterClause.errorGenericParameterClause
        }
        let offset = convert(start)!
        let length = convert(getPreviousEndLocation())! - offset
        return SwiftGenericParameterClause(
            text: getString(offset: offset, length: length)!,
            children: [],
            offset: offset,
            length: length)
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
