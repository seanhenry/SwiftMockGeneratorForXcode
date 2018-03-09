import Source

class FunctionDeclarationParser: DeclarationParser<NamedElement> {

    override func parseDeclaration(offset: Int64) -> NamedElement {
        var name = ""
        try! appendIdentifier(to: &name)
        let parameters = parseParameterClause()
        let end = convert(getPreviousEndLocation())!
        let length = end - offset
        let text = getString(offset: offset, length: length)!
        return SwiftMethodElement(name: name, text: text, children: [], offset: offset, length: length, returnType: nil, parameters: parameters)
    }

    private func parseParameterClause() -> [MethodParameter] {
        return parseFunctionDeclarationParameterClause()
    }

    class ParameterClauseParser: Parser<[MethodParameter]> {

        override func parse() -> [MethodParameter] {
            advance(if: .leftParen)
            if isNext(.rightParen) {
                advance()
                return []
            }
            var parameters = [MethodParameter]()
            tryToAppendParameter(to: &parameters)
            while isNext(.comma) {
                advance()
                tryToAppendParameter(to: &parameters)
            }
            advance(if: .rightParen)
            return parameters
        }

        private func tryToAppendParameter(to parameters: inout [MethodParameter]) {
            parameters.append(parseParameter())
        }

        private func parseParameter() -> MethodParameter {
            return parseFunctionDeclarationParameter()
        }
    }

    class ParameterParser: Parser<MethodParameter> {

        override func parse() -> MethodParameter {
            let start = getCurrentStartLocation()
            guard let (externalParameterName, localParameterName) = parseParameterNames() else { return SwiftMethodParameter.errorMethodParameter }
            let type = parseType()
            let offset = convert(start)!
            let length = convert(getCurrentStartLocation())! - offset
            return SwiftMethodParameter(
                text: getString(offset: offset, length: length)!,
                children: [],
                offset: offset,
                length: length,
                externalParameterName: externalParameterName,
                localParameterName: localParameterName,
                type: type)
        }

        private func parseParameterNames() -> (externalParameterName: String?, localParameterName: String)? {
            guard let firstIdentifier = peekAtNextIdentifier() ?? peekAtNextWildcard() else { return nil }
            advance()
            if let secondIdentifier = peekAtNextIdentifier() {
                advance()
                return (firstIdentifier, secondIdentifier)
            } else {
                return (nil, firstIdentifier)
            }
        }

        private func peekAtNextWildcard() -> String? {
            if isNext(.underscore) {
                return "_"
            }
            return nil
        }

        private func parseType() -> NamedElement {
            skipTypeAnnotation()
            let type = parseTypeIdentifier()
            skipVarArgs()
            return type
        }

        private func skipTypeAnnotation() {
            var string = ""
            tryToAppend(.colon, value: ": ", to: &string)
            tryToAppendAttributes(to: &string)
            tryToAppendInout(to: &string)
        }

        private func skipVarArgs() {
            if isPrefixOperator("...") {
                advance()
            }
        }
    }

    class ResultParser: Parser<Element> {

        override func parse() -> Element {
            _ = parseAttributes()
            guard isNext(.arrow) else {
                return SwiftInheritedType.errorInheritedType
            }
            advance()
            return parseTypeIdentifier()
        }
    }
}
