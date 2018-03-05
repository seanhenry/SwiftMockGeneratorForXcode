class DeclarationsParser: Parser<[Element]> {

    override func parse() -> [Element] {
        var elements = [Element]()
        if isNext(.protocol) {
            elements.append(parseProtocol())
        }
        return elements
    }
}
