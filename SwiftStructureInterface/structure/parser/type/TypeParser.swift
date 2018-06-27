import Lexer

// TODO: no longer parsing Type<Int> or Generic<Type>. Probs should be more flexible
class TypeParser: Parser<Type> {

    private var startStack = [LineColumn]()

    override func parse() throws -> Type {
        if let type = parseSwiftType() {
            return type
        }
        throw LookAheadError()
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
        if let protocolCompositionType = try? parseProtocolCompositionType() {
            return protocolCompositionType
        } else if let typeIdentifier = try? parseTypeIdentifiers() {
            return typeIdentifier
        } else if let arrayType = try? parseArrayType() {
            return arrayType
        } else if let dictionaryType = try? parseDictionaryType() {
            return dictionaryType
        } else if let functionType = try? parseFunctionType() {
            return functionType
        } else if let tupleType = try? parseTupleType() {
            return tupleType
        }
        return nil
    }
}

// MARK: - Type identifier
extension TypeParser {

    fileprivate func parseTypeIdentifiers() throws -> Type {
        var type: TypeIdentifier?
        while let identifier = try? parseTypeIdentifier(type) {
            type = identifier
            if !isNext(.dot) {
                return identifier
            }
        }
        throw LookAheadError()
    }

    private func parseTypeIdentifier(_ parent: TypeIdentifier?) throws -> TypeIdentifier {
        return try TypeIdentifierImpl(children: [parent] + builder()
                .optional { try self.parseDotIfNeeded(parent: parent) }
                .required { try self.parseIdentifier() }
                .optional { try self.parseGenericArgumentClause() }
                .build())
    }

    private func parseDotIfNeeded(parent: Element?) throws -> Element {
        if parent != nil {
            return try parsePunctuation(.dot)
        }
        throw LookAheadError()
    }

    // MARK: - Nested

    private func tryToParseIdentifier() -> Identifier? {
        if let identifier = try? parseIdentifier() {
            return identifier
        } else if let keyword = try? parseKeyword([.Self, .Type, .Protocol, .Any]) {
            return IdentifierImpl(text: keyword.text)
        }
        return nil
    }
}

// MARK: - Array
extension TypeParser {

    fileprivate func parseArrayType() throws -> Type {
        return try ArrayTypeImpl(children:builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parse() }
                .required { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}

// MARK: - Dictionary
extension TypeParser {

    fileprivate func parseDictionaryType() throws -> Type {
        return try DictionaryTypeImpl(children:builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parse() }
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parse() }
                .required { try self.parsePunctuation(.rightSquare) }
                .build())
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

    fileprivate func parseProtocolCompositionType() throws -> Type? {
        return try ProtocolCompositionTypeImpl(children: builder()
                .required { try self.parseTypeIdentifiers() }
                .required { try self.parseOperator("&") }
                .required { try self.parseTypeIdentifiers() }
                .while(isParsed: { try self.parseOperator("&") }) {
                    try self.parseTypeIdentifiers()
                }
                .build())
    }

    private func appendTypeIdentifiers(to children: inout [Element]) throws {
        startStack.append(getCurrentStartLocation())
        defer { startStack.removeLast() }
        if let type = try? parseTypeIdentifiers() {
            children.append(type)
        } else {
            throw LookAheadError()
        }
    }

    private func appendCompositionRHS(to children: inout [Element]) throws {
        try appendAmpBinaryOperator(to: &children)
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

    fileprivate func parseTupleType() throws -> TupleType {
        return try TupleTypeImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseTupleTypeElementList() }
                .required { try self.parsePunctuation(.rightParen) }
                .build())
    }

    class TupleTypeElementListParser: Parser<TupleTypeElementList> {

        override func parse() throws -> TupleTypeElementList {
            return try TupleTypeElementListImpl(children: builder()
                    .optional { try self.parseTupleTypeElement() }
                    .while(isParsed: { try self.parsePunctuation(.comma) }) {
                        try self.parseTupleTypeElement()
                    }
                    .build())
        }
    }

    class TupleTypeElementParser: Parser<TupleTypeElement> {

        override func parse() throws -> TupleTypeElement {
            return try TupleTypeElementImpl(children: builder()
                    .optional { try self.parsePunctuation(.underscore) }
                    .optional { try self.parseArgumentName() }
                    .required { try self.parseTupleType() }
                    .build())
        }

        private func parseArgumentName() throws -> Element {
            let parsed = tryToParse { () -> Element in
                let name = try parseIdentifier()
                if !isNext(.colon) {
                    throw LookAheadError()
                }
                return name
            }
            if let parsed = parsed {
                return parsed
            }
            throw LookAheadError()
        }

        private func parseTupleType() throws -> Element {
            if isNext(.colon) {
                return try parseTypeAnnotation()
            }
            return try parseType()
        }
    }
}

// MARK: - Function type
extension TypeParser {

    fileprivate func parseFunctionType() throws -> Type? {
        return try FunctionTypeImpl(children: builder()
                .optional { try self.parseAttributes() }
                .required { try self.parseTupleType() }
                .optional { try self.parseThrows() }
                .required { try self.parsePunctuation(.arrow) }
                .optional { try self.parse() }
                .build())
    }

    private func appendTupleType(to string: inout String) throws {
        if let tuple = try? parseTupleType() {
            string.append(tuple.text)
        } else {
            throw LookAheadError()
        }
    }
}
