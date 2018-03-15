class RequirementListParser: Parser<String> {

    override func parse(start: LineColumn) -> String {
        var requirements = ""
        repeat {
            tryToAppend(.comma, value: ", ", to: &requirements)
            requirements.append(parseRequirement())
        } while peekAtNextKind() == .comma
        return requirements
    }

    private func parseRequirement() -> String {
        var requirement = ""
        tryToAppendType(to: &requirement)
        let isConformanceRequirement = isNext(.colon)
        if isConformanceRequirement {
            tryToAppend(.colon, value: ":", to: &requirement)
        } else {
            appendSameTypeOperator(to: &requirement)
        }
        tryToAppendType(to: &requirement)
        return requirement
    }

    private func appendType(to string: inout String) {
        let type = parseType().text
        string.append(type)
    }

    private func appendSameTypeOperator(to string: inout String) {
        tryToAppendBinaryOperator("==", value: "==", to: &string)
    }
}
