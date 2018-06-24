import Source

class FunctionDeclarationParser: DeclarationParser<FunctionDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> FunctionDeclaration {
        var name = ""
        try! appendIdentifier(to: &name)
        let genericParameterClause = parseGenericParameterClause()
        let parameters = parseParameterClause()
        let `throws` = parseThrows()
        skipRethrows()
        let returnType = parseReturnType()
        skipWhereClause()
        return createElement(start: start) { offset, length, text in
            return FunctionDeclarationImpl(
                text: text,
                offset: offset,
                length: length,
                name: name,
                genericParameterClause: genericParameterClause,
                parameters: parameters,
                returnType: returnType,
                throws: `throws`,
                declarations: [])
        } ?? FunctionDeclarationImpl.emptyFunctionDeclaration
    }

    private func parseParameterClause() -> [Parameter] {
        return parseFunctionDeclarationParameterClause()
    }

    private func parseThrows() -> Bool {
        if isNext(.throws) {
            advance()
            return true
        }
        return false
    }

    private func skipRethrows() {
        advance(if: .rethrows)
    }

    private func parseReturnType() -> Element? {
        let result = parseFunctionDeclarationResult()
        if result !== TypeImpl.emptyType {
            return result
        }
        return nil
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }

    class ParameterClauseParser: Parser<[Parameter]> {

        override func parse(start: LineColumn) -> [Parameter] {
            advance(if: .leftParen)
            if isNext(.rightParen) {
                advance()
                return []
            }
            var parameters = [Parameter]()
            tryToAppendParameter(to: &parameters)
            while isNext(.comma) {
                advance()
                tryToAppendParameter(to: &parameters)
            }
            advance(if: .rightParen)
            return parameters
        }

        private func tryToAppendParameter(to parameters: inout [Parameter]) {
            parameters.append(parseParameter())
        }

        private func parseParameter() -> Parameter {
            return parseFunctionDeclarationParameter()
        }
    }

    class ParameterParser: Parser<Parameter> {

        override func parse(start: LineColumn) -> Parameter {
            guard let (externalParameterName, localParameterName) = parseParameterNames() else { return ParameterImpl.emptyParameter
            }
            let typeAnnotation = parseParameterTypeAnnotation()
            return createElement(start: start) { offset, length, text in
                ParameterImpl(
                    text: text,
                    offset: offset,
                    length: length,
                    typeAnnotation: typeAnnotation,
                    externalParameterName: externalParameterName,
                    localParameterName: localParameterName)
            } ?? ParameterImpl.emptyParameter
        }

        private func parseParameterNames() -> (externalParameterName: String?, localParameterName: String)? {
            guard let firstIdentifier = peekAtNextParameterIdentifier() ?? peekAtNextWildcard() else { return nil }
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

        private func parseParameterTypeAnnotation() -> TypeAnnotation {
            let typeAnnotation = parseTypeAnnotation()
            skipVarArgs()
            return typeAnnotation
        }

        private func skipVarArgs() {
            if isPostfixOperator("...") {
                advance()
            }
        }
    }

    class ResultParser: Parser<Element> {

        override func parse(start: LineColumn) -> Element {
            guard isNext(.arrow) else {
                return TypeImpl.emptyType
            }
            advance()
            _ = parseAttributes()
            return parseType()
        }
    }
}
