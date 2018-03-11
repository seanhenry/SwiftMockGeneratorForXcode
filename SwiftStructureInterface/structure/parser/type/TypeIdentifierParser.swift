import Lexer

class TypeIdentifierParser: Parser<Type> {

    private var startStack = [LineColumn]()

    override func parse() -> Type {
        if let type = parseType() {
            return type
        }
        return SwiftType.errorType
    }

    private func createPartialElement() -> (offset: Int64, length: Int64, text: String) {
        let offset = convert(startStack.last!)!
        let length = convert(getPreviousEndLocation())! - offset
        return (offset, length, getString(offset: offset, length: length)!)
    }

    private func parseType() -> Type? {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        return parseOptional()
    }

    private func parseTypeExcludingOptional() -> Type? {
        if let protocolCompositionType = parseProtocolCompositionType() {
            return protocolCompositionType
        } else if let typeIdentifier = _parseTypeIdentifier() {
            return typeIdentifier
        } else if let arrayType = parseArrayType() {
            return arrayType
        } else if let dictionaryType = parseDictionaryType() {
            return dictionaryType
        } else if let functionType = parseFunctionType() {
            return functionType
        } else if let tupleType = parseTupleType() {
            return tupleType
        }
        return nil
    }

    private func _parseTypeIdentifier() -> Type? {
        guard let type = parseTypeName() else { return nil }
        return parseGenericClause(type)
    }

    private func parseTypeName() -> Type? {
        return parseIdentifier()
    }

    private func parseIdentifier() -> Type? {
        if let implicit = parseImplicitParameterName() {
            return implicit
        } else if peekAtNextIdentifier() != nil {
            advance()
            skipNestedTypes()
            return createSwiftType()
        }
        return nil
    }

    // MARK: - Implicit

    private func parseImplicitParameterName() -> Type? {
        if peekAtNextImplicitParameterName() != nil {
            advance()
            return createSwiftType()
        }
        return nil
    }

    private func createSwiftType() -> Type {
        let element = createPartialElement()
        return SwiftType(text: element.text, children: [], offset: element.offset, length: element.length)
    }

    // MARK: - Nested

    private func skipNestedTypes() {
        while isNext(.dot) {
            advance()
            skipIdentifier()
        }
    }

    // MARK: - Generic

    private func skipIdentifier() {
        if peekAtNextIdentifier() != nil {
            advance()
        }
    }

    private func parseGenericClause(_ type: Type) -> Type {
        var clause = "" // TODO: remove
        do {
            try appendGenericClauseStart(to: &clause)
            tryToAppendType(to: &clause)
            appendGenericArgumentList(to: &clause)
            try? appendGenericClauseEnd(to: &clause)
            skipNestedTypes()
            _ = parseGenericClause(type)
            return createSwiftType()
        } catch {} // ignored
        return type
    }

    private func appendGenericClauseStart(to string: inout String) throws {
        if isGenericClauseStart() {
            advanceOperator("<")
            string.append("<")
        } else {
            throw LookAheadError()
        }
    }

    private func skipType() {
        _ = parse()
    }

    private func appendGenericArgumentList(to string: inout String) {
        while isNext(.comma) {
            advance()
            string.append(", ")
            tryToAppendType(to: &string)
        }
    }

    private func appendGenericClauseEnd(to string: inout String) throws {
        if isGenericClauseEnd() {
            string.append(">")
            advanceOperator(">")
        } else {
            throw LookAheadError()
        }
    }

    private func isGenericClauseStart() -> Bool {
        return isNext("<")
    }

    private func isGenericClauseEnd() -> Bool {
        return isNext(">")
    }

    // MARK: - Array

    private func parseArrayType() -> Type? {
        return tryToParse {
            try advanceOrFail(if: .leftSquare)
            let type = parseTypeIdentifier()
            try advanceOrFail(if: .rightSquare)
            return createArrayType(type)
        }
    }

    private func createArrayType(_ type: Type) -> Type {
        let element = createPartialElement()
        return SwiftArrayType(text: element.text, children: [type], offset: element.offset, length: element.length, elementType: type)
    }

    // MARK: - Dictionary

    private func parseDictionaryType() -> Type? {
        return tryToParse {
            try advanceOrFail(if: .leftSquare)
            let keyType = parseTypeIdentifier()
            try advanceOrFail(if: .colon)
            let valueType = parseTypeIdentifier()
            try advanceOrFail(if: .rightSquare)
            return createDictionaryType(keyType, valueType)
        }
    }

    private func createDictionaryType(_ key: Type, _ value: Type) -> DictionaryType {
        let element = createPartialElement()
        return SwiftDictionaryType(
            text: element.text,
            children: [key, value],
            offset: element.offset,
            length: element.length,
            keyType: key,
            valueType: value)
    }

    // MARK: - Optional

    private func parseOptional() -> Type? {
        return tryToParse {
            guard let type = parseTypeExcludingOptional() else { throw LookAheadError() }
            var innerType = type
            while isNext("?") || isNext("!") {
                if isNext("?") {
                    advanceOperator("?")
                } else {
                    advanceOperator("!")
                }
                innerType = createOptional(innerType)
            }
            return innerType
        }
    }

    private func appendOptional(to type: Type) -> Type {
        if isNext(.postfixQuestion) {
            advance()
            return createOptional(type)
        } else if isNext(.postfixExclaim) {
            advance()
            return createOptional(type)
        } else if isNext("!") {
            advanceOperator("!")
            return createOptional(type)
        } else if isNext("?") {
            advanceOperator("?")
            return createOptional(type)
        } else {
            return type
        }
    }

    private func createOptional(_ type: Type) -> OptionalType {
        let element = createPartialElement()
        return SwiftOptionalType(
            text: element.text,
            children: [type],
            offset: element.offset,
            length: element.length,
            type: type)
    }

    // MARK: - Protocol composition

    func parseProtocolCompositionType() -> Type? {
        return tryToParse {
            var types = [Type]()
            try appendTypeIdentifier(to: &types)
            try appendCompositionRHS(to: &types)
            repeat {
                try? appendCompositionRHS(to: &types)
            } while isNextAmpBinaryOperator()
            return createProtocolComposition(types)
        }
    }

    private func appendTypeIdentifier(to string: inout [Type]) throws {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        if let type = _parseTypeIdentifier() {
            string.append(type)
        } else {
            throw LookAheadError()
        }
    }

    private func appendCompositionRHS(to types: inout [Type]) throws {
        try assertAmpBinaryOperator()
        try appendTypeIdentifier(to: &types)
    }

    private func assertAmpBinaryOperator() throws {
        if isNextAmpBinaryOperator() {
            advanceOperator("&")
        } else {
            throw LookAheadError()
        }
    }

    private func isNextAmpBinaryOperator() -> Bool {
        return isNext("&")
    }

    private func createProtocolComposition(_ types: [Type]) -> Type {
        let element = createPartialElement()
        return SwiftProtocolCompositionType(
            text: element.text,
            children: types,
            offset: element.offset,
            length: element.length,
            types: types)
    }

    // MARK: - Tuple

    private func parseTupleType() -> Type? {
        return tryToParse {
            var tuple = ""
            try append(.leftParen, value: "(", to: &tuple)
            tryToAppendTupleArgument(to: &tuple)
            repeat {
                try? append(.comma, value: ", ", to: &tuple)
                tryToAppendTupleArgument(to: &tuple)
            } while isNext(.comma)
            try append(.rightParen, value: ")", to: &tuple)
            return createSwiftType()
        }
    }

    private func tryToAppendTupleArgument(to string: inout String) {
        tryToAppendWildcard(to: &string)
        tryToAppendTupleArgumentName(to: &string)
        tryToAppendTypeAnnotation(to: &string)
    }

    private func tryToAppendWildcard(to string: inout String) {
        if isNext(.underscore) {
            advance()
            string.append("_ ")
        }
    }

    private func tryToAppendTupleArgumentName(to string: inout String) {
        let name = tryToParse { () -> String in
            var name = ""
            try appendIdentifier(to: &name)
            if !isNext(.colon) {
                throw LookAheadError()
            }
            return name
        }
        name.map { string.append($0) }
    }

    // MARK: - Function type

    private func parseFunctionType() -> Type? {
        return tryToParse {
            var function = ""
            tryToAppendAttributes(to: &function)
            try appendTupleType(to: &function)
            tryToAppend(.throws, value: " throws", to: &function)
            tryToAppend(.rethrows, value: " rethrows", to: &function)
            try append(.arrow, value: " -> ", to: &function)
            tryToAppendType(to: &function)
            return createSwiftType()
        }
    }

    private func appendTupleType(to string: inout String) throws {
        if let tuple = parseTupleType() {
            string.append(tuple.text)
        } else {
            throw LookAheadError()
        }
    }

    override func tryToAppendType(to string: inout String) {
        string.append(parse().text)
    }
}
