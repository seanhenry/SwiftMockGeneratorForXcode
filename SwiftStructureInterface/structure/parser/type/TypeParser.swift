import Lexer

class TypeParser: Parser<Type> {

    private var startStack = [LineColumn]()

    override func parse(start: LineColumn) -> Type {
        if let type = parseSwiftType() {
            return type
        }
        return TypeImpl.emptyType
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
            }
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
}

// MARK: - Type identifier
extension TypeParser {

    fileprivate func parseTypeIdentifiers() -> Type? {
        var type: TypeIdentifier?
        while let identifier = parseTypeIdentifier(type) {
            type = identifier
            if isNext(.dot) {
                advance()
            } else {
                break
            }
        }
        return type
    }

    private func parseTypeIdentifier(_ parent: TypeIdentifier?) -> TypeIdentifier? {
        if let identifier = tryToParseIdentifier() {
            return TypeIdentifierImpl(children: [
                parent,
                parent != nil ? Punctuation.dot : nil,
                identifier,
                isGenericArgumentClauseNext() ? parseWhitespace() : nil,
                parseGenericArgumentClause()
            ])
        }
        return parent
    }

    private func isGenericArgumentClauseNext() -> Bool {
        return isNext("<")
    }

    // MARK: - Nested

    private func tryToParseIdentifier() -> Identifier? {
        return try? parseIdentifier()
    }
}

// MARK: - Array
extension TypeParser {

    fileprivate func parseArrayType() -> Type? {
        return tryToParse {
            return ArrayTypeImpl(children: [
                try parsePunctuation(.leftSquare),
                parseWhitespace(),
                parse(),
                parseWhitespace(),
                try parsePunctuation(.rightSquare)
            ])
        }
    }
}

// MARK: - Dictionary
extension TypeParser {

    fileprivate func parseDictionaryType() -> Type? {
        return tryToParse {
            return DictionaryTypeImpl(children: [
                try parsePunctuation(.leftSquare),
                parseWhitespace(),
                parseKey(),
                parseWhitespace(),
                try parsePunctuation(.colon),
                parseWhitespace(),
                parseValue(),
                parseWhitespace(),
                try parsePunctuation(.rightSquare)
            ])
        }
    }

    private func parseValue() -> Type {
        return parse()
    }

    private func parseKey() -> Type {
        return parse()
    }
}

// MARK: - Optional
extension TypeParser {

    fileprivate func parseOptional() -> Type? {
        return tryToParse {
            guard let type = parseTypeExcludingOptional() else {
                throw LookAheadError()
            }
            return surroundWithOptional(type)
        }
    }

    private func surroundWithOptional(_ type: Type) -> Type {
        var optionalType = type
        while isNextOptionalPostfix() {
            optionalType = OptionalTypeImpl(children: [optionalType, parseOptionalPostfix()])
        }
        return optionalType
    }

    private func isNextOptionalPostfix() -> Bool {
        return isNext("?") || isNext("!")
    }

    private func parseOptionalPostfix() -> Element? {
        var opt: Element?
        if isNext("?") {
            opt = LeafNodeImpl(text: "?")
            advanceOperator("?")
        } else {
            opt = LeafNodeImpl(text: "!")
            advanceOperator("!")
        }
        return opt
    }
}

// MARK: - Protocol composition
extension TypeParser {

    fileprivate func parseProtocolCompositionType() -> Type? {
        return tryToParse {
            var types = [Element]()
            try appendTypeIdentifiers(to: &types)
            try appendCompositionRHS(to: &types)
            while isNextAmpBinaryOperator() {
                try? appendCompositionRHS(to: &types)
            }
            return ProtocolCompositionTypeImpl(children: types)
        }
    }

    private func appendTypeIdentifiers(to children: inout [Element]) throws {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        if let type = parseTypeIdentifiers() {
            children.append(type)
        } else {
            throw LookAheadError()
        }
    }

    private func appendCompositionRHS(to children: inout [Element]) throws {
        children.append(parseWhitespace())
        try appendAmpBinaryOperator(to: &children)
        children.append(parseWhitespace())
        try appendTypeIdentifiers(to: &children)
    }

    private func appendAmpBinaryOperator(to children: inout [Element]) throws {
        try children.append(parseOperator("&"))
    }

    private func isNextAmpBinaryOperator() -> Bool {
        return isNext("&")
    }
}

// MARK: - Tuple
extension TypeParser {

    fileprivate func parseTupleType() -> TupleType? {
        return tryToParse {
            TupleTypeImpl(children: [
                try parsePunctuation(.leftParen),
                parseWhitespace(),
                parseTupleElementList(),
                parseWhitespace(),
                try parsePunctuation(.rightParen)
            ])
        }
    }

    private func parseTupleElementList() -> TupleTypeElementList {
        var elements = [Element]()
        repeat {
            tryToParseComma(addingTo: &elements)
            parseTupleElement(addingTo: &elements)
        } while isNext(.comma)
        return TupleTypeElementListImpl(children: elements)
    }

    private func tryToParseComma(addingTo children: inout [Element]) {
        tryToParse {
            let elements = [
                parseWhitespace(),
                try parsePunctuation(.comma),
                parseWhitespace()
            ]
            children.append(contentsOf: elements)
        }
    }

    private func parseTupleElement(addingTo children: inout [Element]) {
        if !isNext(.rightParen) {
            children.append(parseTupleTypeElement())
        }
    }

    class TupleTypeElementParser: Parser<TupleTypeElement> {

        override func parse(start: LineColumn) -> TupleTypeElement {
            return TupleTypeElementImpl(children: [
                parseUnderscoreAndWhitespace(),
                parseArgumentName(),
                parseTupleType()
            ])
        }

        private func parseArgumentName() -> [Element]? {
            return tryToParse { () -> [Element] in
                let name = try parseIdentifier()
                if !isNext(.colon) {
                    throw LookAheadError()
                }
                return [name, parseWhitespace()]
            }
        }

        private func parseTupleType() -> Element {
            if isNext(.colon) {
                return parseTypeAnnotation()
            }
            return parseType()
        }
    }
}

// MARK: - Function type
extension TypeParser {

    fileprivate func parseFunctionType() -> Type? {
        return tryToParse {
            return FunctionTypeImpl(children: [
                parseFunctionAttributes(),
                try parseTupleOrFail(),
                parseWhitespace(),
                parseThrows(),
                try parseArrow(),
                parseReturnType()
            ])
        }
    }

    private func parseFunctionAttributes() -> [Element]? {
        if isNext(.at) {
            return [parseAttributes(), parseWhitespace()]
        }
        return [parseAttributes()]
    }

    private func parseTupleOrFail() throws -> TupleType {
        guard let tuple = parseTupleType() else { throw LookAheadError() }
        return tuple
    }

    private func parseThrows() -> [Element]? {
        if isNext(.throws) || isNext(.rethrows) {
            return [parseKeyword(), parseWhitespace()]
        }
        return nil
    }

    private func parseArrow() throws -> [Element] {
        return [
            try parsePunctuation(.arrow),
            parseWhitespace()
        ]
    }

    private func parseReturnType() -> Type {
        return parse()
    }

    private func appendTupleType(to string: inout String) throws {
        if let tuple = parseTupleType() {
            string.append(tuple.text)
        } else {
            throw LookAheadError()
        }
    }
}
