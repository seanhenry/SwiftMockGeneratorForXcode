import Lexer

class TypeParser: Parser<Type> {

    private var startStack = [LineColumn]()

    override func parse(start: LineColumn) -> Type {
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

    private func createTypeElement<T: Type>(closure: (Int64, Int64, String) -> T) -> T? {
        if let start = startStack.last {
            return createElement(start: start) { offset, length, text in
                return closure(offset, length, text)
            } as? T
        }
        return nil
    }

    private func parseTypeExcludingOptional() -> Type? {
        if let protocolCompositionType = parseProtocolCompositionType() {
            return protocolCompositionType
        } else if let typeIdentifier = parseTypeIdentifiers() {
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

    private func parseTypeIdentifiers() -> Type? {
        var type: TypeIdentifier?
        while let identifier = parseTypeIdentifier(type) {
            type = identifier
            do {
                try advanceOrFail(if: .dot)
            } catch {
                break
            }
        }
        return type
    }

    private func parseTypeIdentifier(_ parent: TypeIdentifier?) -> TypeIdentifier? {
        if let identifier = parseIdentifier() {
            let genericArguments = parseGenericClause()
            let children = [parent].compactMap { $0 }
            return createTypeElement() { offset, length, text in
                return SwiftTypeIdentifier(
                    text: text,
                    children: children + genericArguments,
                    offset: offset,
                    length: length,
                    typeName: identifier,
                    genericArguments: genericArguments,
                    parentType: parent)
            }
        }
        return parent
    }

    // MARK: - Nested

    private func parseIdentifier() -> String? {
        if let identifier = peekAtNextIdentifier() {
            advance()
            return identifier
        }
        return nil
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
        return createTypeElement() { offset, length, text in
            return SwiftType(text: text, children: [], offset: offset, length: length)
        } ?? SwiftType.errorType
    }

    // MARK: - Generic

    private func parseGenericClause() -> [Type] {
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
        return createTypeElement() { offset, length, text in
            return SwiftArrayType(text: text, children: [type], offset: offset, length: length, elementType: type)
        } ?? SwiftArrayType.errorArrayType
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
        return createTypeElement() { offset, length, text in
            return SwiftDictionaryType(
                text: text,
                children: [key, value],
                offset: offset,
                length: length,
                keyType: key,
                valueType: value)
        } ?? SwiftDictionaryType.errorDictionaryType
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
        return createTypeElement() { offset, length, text in
            return SwiftOptionalType(
                text: text,
                children: [type],
                offset: offset,
                length: length,
                type: type)
        } ?? SwiftOptionalType.errorOptionalType
    }

    // MARK: - Protocol composition

    func parseProtocolCompositionType() -> Type? {
        return tryToParse {
            var types = [Type]()
            try appendTypeIdentifiers(to: &types)
            try appendCompositionRHS(to: &types)
            repeat {
                try? appendCompositionRHS(to: &types)
            } while isNextAmpBinaryOperator()
            return createProtocolComposition(types)
        }
    }

    private func appendTypeIdentifiers(to string: inout [Type]) throws {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        if let type = parseTypeIdentifiers() {
            string.append(type)
        } else {
            throw LookAheadError()
        }
    }

    private func appendCompositionRHS(to types: inout [Type]) throws {
        try assertAmpBinaryOperator()
        try appendTypeIdentifiers(to: &types)
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
        return createTypeElement() { offset, length, text in
            return SwiftProtocolCompositionType(
                text: text,
                children: types,
                offset: offset,
                length: length,
                types: types)
        } ?? SwiftProtocolCompositionType.errorProtocolCompositionType
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
