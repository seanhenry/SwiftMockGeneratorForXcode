class WhitespaceParser: Parser<Whitespace> {

    override func parse() throws -> Whitespace {
        let start = getCurrentStartLocation()
        let previousEnd = getPreviousEndLocation()
        guard let text = getSubstring(previousEnd, start) else {
            let id = setCheckPoint()
            defer { restoreCheckPoint(id) }
            advance()
            return try parse()
        }
        if text.isEmpty {
            throw LookAheadError()
        }
        return WhitespaceImpl(text: text)
    }
}
