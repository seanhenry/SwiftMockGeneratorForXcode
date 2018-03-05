import Lexer

class RequirementListParser: Parser<String> {

    override func parse() -> String {
        var requirements = ""
        repeat {
            append(.comma, value: ", ", to: &requirements)
            requirements.append(parseRequirement())
        } while peekAtNextKind() == .comma
        return requirements
    }

    private func parseRequirement() -> String {
        var requirement = ""
        appendIdentifier(to: &requirement)
        let isConformanceRequirement = isNext(.colon)
        if isConformanceRequirement {
            append(.colon, value: ":", to: &requirement)
            appendConformanceRequirementRHS(to: &requirement)
        } else {
            appendSameTypeOperator(to: &requirement)
            appendIdentifier(to: &requirement)
        }
        return requirement
    }

    private func append(_ kind: Token.Kind, value: String, to string: inout String) {
        if isNext(kind) {
            advance()
            string.append(value)
        }
    }

    private func appendIdentifier(to string: inout String) {
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
        appendIdentifier(to: &string)
    }
}
