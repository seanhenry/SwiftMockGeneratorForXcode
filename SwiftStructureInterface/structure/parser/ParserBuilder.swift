class ParserBuilder {

    typealias ElementSupplier = () throws -> Element?
    private var operations = [Operation]()
    private let whitespaceParser: Parser<Whitespace>
    private struct RequiredElementNotParsedError: Error {}
    private struct PlaceholderError: Error {}

    private enum Operation {
        case required(ElementSupplier)
        case optional(ElementSupplier)
        case `while`(ElementSupplier, ElementSupplier)
    }

    init(whitespaceParser: Parser<Whitespace>) {
        self.whitespaceParser = whitespaceParser
    }

    func required(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(.required(parse))
        return self
    }

    func optional(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(.optional(parse))
        return self
    }

    func `while`(isParsed: @escaping ElementSupplier, _ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(.`while`(isParsed, parse))
        return self
    }

    func `while`(_ parse: @escaping ElementSupplier) -> ParserBuilder {
        operations.append(.`while`(parse, { throw PlaceholderError() }))
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
            let parsed = try parseOperation(op)
            if !parsed.isEmpty {
                children.append(contentsOf: parsed)
                if i != operations.count-1 {
                    appendWhitespace(to: &children)
                }
            }
        }
        if children.last is Whitespace {
            children.removeLast()
        }
        return children
    }

    private func parseOperation(_ operation: Operation) throws -> [Element] {
        switch operation {
        case let .required(supplier):
            if let element = (try? supplier()) as? Element { // TODO:
                return [element]
            }
            throw RequiredElementNotParsedError()
        case let .optional(supplier):
            return ((try? supplier()) as? Element).flatMap { [$0] } ?? [] // TODO:
        case let .`while`(isParsed, parse):
            var children = [Element]()
            while let parsed = (try? isParsed()) as? Element {
                children.append(parsed)
                appendWhitespace(to: &children)
                let parsed2 = (try? parse()) as? Element
                parsed2.flatMap {
                    children.append($0)
                    appendWhitespace(to: &children)
                }
            }
            if children.last is Whitespace {
                children.removeLast()
            }
            return children
        }
    }

    private func appendWhitespace(to children: inout [Element]) {
        do {
            children.append(try whitespaceParser.parse())
        } catch {}
    }
}
