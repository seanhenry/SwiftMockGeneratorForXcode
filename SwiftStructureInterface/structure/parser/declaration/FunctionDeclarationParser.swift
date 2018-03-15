import Source

class FunctionDeclarationParser: DeclarationParser<FunctionDeclaration> {

    override func parseDeclaration(start: LineColumn) -> FunctionDeclaration {
        var name = ""
        try! appendIdentifier(to: &name)
        let genericParameterClause = parseGenericParameterClause()
        let parameters = parseParameterClause()
        let `throws` = parseThrows()
        skipRethrows()
        let returnType = parseReturnType()
        skipWhereClause()
        var children = [genericParameterClause] as [Element]
        children.append(contentsOf: parameters as [Element])
        returnType.map { children.append($0) }
        return createElement(start: start) { offset, length, text in
            return SwiftFunctionDeclaration(name: name,
                text: text,
                children: children,
                offset: offset,
                length: length,
                returnType: returnType,
                genericParameterClause: genericParameterClause,
                parameters: parameters,
                throws: `throws`)
        } ?? SwiftFunctionDeclaration.errorFunctionDeclaration
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
        if result !== SwiftType.errorType {
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
            guard let (externalParameterName, localParameterName) = parseParameterNames() else { return SwiftParameter.errorParameter }
            let type = parseParameterType()
            return createElement(start: start) { offset, length, text in
                SwiftParameter(
                    text: text,
                    children: [type],
                    offset: offset,
                    length: length,
                    externalParameterName: externalParameterName,
                    localParameterName: localParameterName,
                    type: type)
            } ?? SwiftParameter.errorParameter
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

        private func parseParameterType() -> Element {
            skipTypeAnnotation()
            let type = parseType()
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

        override func parse(start: LineColumn) -> Element {
            guard isNext(.arrow) else {
                return SwiftType.errorType
            }
            advance()
            _ = parseAttributes()
            return parseType()
        }
    }
}
