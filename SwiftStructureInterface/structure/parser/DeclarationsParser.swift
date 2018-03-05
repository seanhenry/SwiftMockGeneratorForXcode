class DeclarationsParser: Parser<[Element]> {

    override func parse() -> [Element]? {
        var elements = [Element]()
        parseProtocol().map { elements.append($0) }
        return elements
    }
}
