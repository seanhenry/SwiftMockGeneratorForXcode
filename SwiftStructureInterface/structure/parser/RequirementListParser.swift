class RequirementListParser: Parser<String> {

    override func parse() -> String {
        var requirements = ""
        repeat {
            tryToAppend(.comma, value: ", ", to: &requirements)
            requirements.append(parseRequirement())
        } while peekAtNextKind() == .comma
        return requirements
    }

    private func parseRequirement() -> String {
        var requirement = ""
        appendType(to: &requirement)
        let isConformanceRequirement = isNext(.colon)
        if isConformanceRequirement {
            tryToAppend(.colon, value: ":", to: &requirement)
            appendConformanceRequirementRHS(to: &requirement)
        } else {
            appendSameTypeOperator(to: &requirement)
            appendType(to: &requirement)
        }
        return requirement
    }

    private func appendType(to string: inout String) {
        let type = parseInheritanceType().text
        string.append(type)
    }

    private func appendSameTypeOperator(to string: inout String) {
        if case let .binaryOperator(op) = peekAtNextKind(), op == "==" {
            advance()
            string.append("==")
        }
    }

    private func appendConformanceRequirementRHS(to string: inout String) {
        let composition = parseProtocolComposition()
        if composition != "" {
            string.append(composition)
        }
        appendType(to: &string)
    }
}
