class GenericParameterClauseParser: Parser<String> {

    override func parse() -> String {
        var clause = ""
        if isNext(.leftChevron) {
            advance()
            clause.append("<")
            clause.append(parseGenericParameterList())
            tryToAppend(.rightChevron, value: ">", to: &clause)
        }
        return clause
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
}
