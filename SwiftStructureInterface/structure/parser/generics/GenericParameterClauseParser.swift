class GenericParameterClauseParser: Parser<GenericParameterClause> {

    override func parse(start: LineColumn) -> GenericParameterClause {
        guard isNext("<") else {
            return SwiftGenericParameterClause.emptyGenericParameterClause
        }
        advanceOperator("<")
        let parameters = parseGenericParameterList()
        parseGenericClosingBracket()
        return createElement(start: start) { offset, length, text in
            return SwiftGenericParameterClause(
                text: text,
                children: parameters,
                offset: offset,
                length: length,
                parameters: parameters)
        } ?? SwiftGenericParameterClause.errorGenericParameterClause
    }

    private func parseGenericParameterList() -> [GenericParameter] {
        var parameterList = [GenericParameter]()
        repeat {
            advance(if: .comma)
            parameterList.append(parseGenericParameter())
        } while isNext(.comma)
        return parameterList
    }

    private func parseGenericParameter() -> GenericParameter {
        let offset = convert(getCurrentStartLocation())!
        guard let typeName = peekAtNextIdentifier() else {
            return GenericParameterImpl.errorGenericParameter
        }
        advance()
        advance(if: .colon)
        let type = parseType()
        let typeIdentifier = type as? TypeIdentifier
        let protocolComposition = type as? ProtocolCompositionType
        let children = [typeIdentifier as Element?, protocolComposition as Element?].compactMap { $0 }
        let length = convert(getPreviousEndLocation())! - offset
        return GenericParameterImpl(text: "",
            children: children,
            offset: offset,
            length: length,
            typeName: typeName,
            typeIdentifier: typeIdentifier,
            protocolComposition: protocolComposition)
    }

    private func parseGenericClosingBracket() {
        if isNext(">") {
            advanceOperator(">")
        }
    }
}
