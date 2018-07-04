typealias ElementSupplier = () throws -> Element
typealias CheckClosure = () throws -> ()

private protocol ParsingStrategy {
    func parse(into children: inout [Element]) throws
}

private struct RequiredElementNotParsedError: Error {}
private struct PlaceholderError: Error {}

class ParserBuilder {

    private var operations = [ParsingStrategy]()
    private let whitespaceParser: Parser<Whitespace>
    private let whitespaceStrategy: ParsingStrategy

    init(whitespaceParser: Parser<Whitespace>) {
        self.whitespaceParser = whitespaceParser
        whitespaceStrategy = WhitespaceStrategy { try whitespaceParser.parse() }
    }

    func required(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(RequiredStrategy(parse))
        return self
    }

    func optional(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(OptionalStrategy(parse))
        return self
    }

    func either(_ either: @escaping ElementSupplier, or: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(EitherOrStrategy(RequireEitherOrStrategy(either, or)))
        return self
    }

    func requireEither(_ either: @escaping ElementSupplier, or: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(RequireEitherOrStrategy(either, or))
        return self
    }

    func `while`(isParsed: @escaping ElementSupplier, _ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(WhileStrategy(isParsed, parse, whitespaceStrategy))
        return self
    }

    func `while`(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(WhileStrategy(parse, { throw PlaceholderError() }, whitespaceStrategy))
        return self
    }

    func check(_ check: @escaping CheckClosure) -> ParserBuilder {
        operations.append(CheckStrategy(check))
        return self
    }

    func build() throws -> [Element] {
        let checkpoint = whitespaceParser.setCheckPoint()
        do {
            return try buildChildren()
        } catch {
            whitespaceParser.restoreCheckPoint(checkpoint)
            throw error
        }
    }

    private func buildChildren() throws -> [Element] {
        var children = [Element]()
        for (i, op) in operations.enumerated() {
            let count = children.count
            try op.parse(into: &children)
            if children.count > count && i != operations.count-1 {
                appendWhitespace(to: &children)
            }
        }
        if children.last is Whitespace {
            children.removeLast()
        }
        return children
    }

    private func appendWhitespace(to children: inout [Element]) {
        try? children.append(whitespaceParser.parse())
    }

    private class RequiredStrategy: ParsingStrategy {
        let supplier: ElementSupplier

        init(_ supplier: @escaping ElementSupplier) {
            self.supplier = supplier
        }

        func parse(into children: inout [Element]) throws {
            if let element = try? supplier() {
                children.append(element)
            } else {
                throw RequiredElementNotParsedError()
            }
        }
    }

    private class OptionalStrategy: ParsingStrategy {
        let supplier: ElementSupplier

        init(_ supplier: @escaping ElementSupplier) {
            self.supplier = supplier
        }

        func parse(into children: inout [Element]) throws {
            if let element = try? supplier() {
                children.append(element)
            }
        }
    }

    private class WhileStrategy: ParsingStrategy {
        let `while`: ElementSupplier
        let parse: ElementSupplier
        let parseWhitespace: ParsingStrategy

        init(_ while: @escaping ElementSupplier, _ parse: @escaping ElementSupplier, _ parseWhitespace: ParsingStrategy) {
            self.`while` = `while`
            self.parse = parse
            self.parseWhitespace = parseWhitespace
        }

        func parse(into children: inout [Element]) throws {
            children.append(contentsOf: parseAll())
        }

        func parseAll() -> [Element] {
            var children = [Element]()
            while let parsed = try? `while`() {
                children.append(parsed)
                parseWhitespace(into: &children)
                parseSecond(into: &children)
            }
            if children.last is Whitespace {
                children.removeLast()
            }
            return children
        }

        private func parseWhitespace(into children: inout [Element]) {
            try? parseWhitespace.parse(into: &children)
        }

        private func parseSecond(into children: inout [Element]) {
            if let parsed = try? parse() {
                children.append(parsed)
                parseWhitespace(into: &children)
            }
        }
    }

    private class WhitespaceStrategy: ParsingStrategy {
        let supplier: ElementSupplier

        init(_ supplier: @escaping ElementSupplier) {
            self.supplier = supplier
        }

        func parse(into children: inout [Element]) throws {
            try? children.append(supplier())
        }
    }

    private class EitherOrStrategy: ParsingStrategy {
        let strategy: RequireEitherOrStrategy

        init(_ strategy: RequireEitherOrStrategy) {
            self.strategy = strategy
        }

        func parse(into children: inout [Element]) throws {
            do {
                try strategy.parse(into: &children)
            } catch {}
        }
    }

    private class RequireEitherOrStrategy: ParsingStrategy {
        let either: ElementSupplier
        let or: ElementSupplier

        init(_ either: @escaping ElementSupplier, _ or: @escaping ElementSupplier) {
            self.either = either
            self.or = or
        }

        func parse(into children: inout [Element]) throws {
            if let first = try? either() {
                children.append(first)
            } else if let second = try? or() {
                children.append(second)
            } else {
                throw RequiredElementNotParsedError()
            }
        }
    }

    private class CheckStrategy: ParsingStrategy {
        let check: CheckClosure

        init(_ check: @escaping CheckClosure) {
            self.check = check
        }

        func parse(into children: inout [Element]) throws {
            try check()
        }
    }
}
