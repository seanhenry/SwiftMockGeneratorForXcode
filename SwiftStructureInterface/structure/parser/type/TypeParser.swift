import Lexer

class TypeParser: Parser<Type> {

    private var startStack = [LineColumn]()

    override func parse() -> Type {
        if let type = parseSwiftType() {
            return type
        }
        return SwiftType.errorType
    }

    private func parseSwiftType() -> Type? {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        return parseOptional()
    }

    private func createPartialElement() -> (offset: Int64, length: Int64, text: String) {
        let offset = convert(startStack.last!)!
        let length = convert(getPreviousEndLocation())! - offset
        return (offset, length, getString(offset: offset, length: length)!)
    }

    private func parseTypeExcludingOptional() -> Type? {
        if let protocolCompositionType = parseProtocolCompositionType() {
            return protocolCompositionType
        } else if let typeIdentifier = parseTypeIdentifier() {
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

    // MARK: - Type identifier

    private func parseTypeIdentifier() -> Type? {
        guard let type = parseTypeName().last else { return nil }
        let genericArguments = parseGenericClause(type)
        if isNext(.dot) {
            advance()
            return parseTypeIdentifier()
        } else {
            let element = createPartialElement()
            return SwiftTypeIdentifier(
                text: element.text,
                children: [type] + genericArguments,
                offset: element.offset,
                length: element.length,
                type: type,
                genericArguments: genericArguments)
        }
    }

    // MARK: - Nested

    private func parseTypeName() -> [Type] {
        return parseNestedTypes()
    }

    private func parseNestedTypes() -> [Type] {
        var types = [Type]()
        appendIdentifier(to: &types)
        while isNext(.dot) {
            advance()
            appendIdentifier(to: &types)
        }
        return types
    }

    private func appendIdentifier(to types: inout [Type]) {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        if peekAtNextIdentifier() != nil {
            advance()
            types.append(createSwiftType())
        }
    }

    private func createSwiftType() -> Type {
        let element = createPartialElement()
        return SwiftType(text: element.text, children: [], offset: element.offset, length: element.length)
    }

    // MARK: - Generic

    private func parseGenericClause(_ type: Type) -> [Type] {
        var clause = [Type]()
        do {
            try advanceOrFail(if: "<")
            clause.append(parse())
            appendGenericArgumentList(to: &clause)
            advance(if: ">")
        } catch {} // ignored
        return clause
    }

    private func appendGenericArgumentList(to clause: inout [Type]) {
        while isNext(.comma) {
            advance()
            clause.append(parse())
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
            let type = parse()
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
            let keyType = parse()
            try advanceOrFail(if: .colon)
            let valueType = parse()
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
        if let type = parseTypeIdentifier() {
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
