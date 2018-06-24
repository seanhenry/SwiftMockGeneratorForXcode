class WhitespaceParser: Parser<Whitespace> {

    override func parse(start: LineColumn) -> Whitespace {
        let previousEnd = getPreviousEndLocation()
        guard let text = getSubstring(previousEnd, start) else {
            let id = setCheckPoint()
            defer { restoreCheckPoint(id) }
            advance()
            return parse(start: getCurrentStartLocation())
        }
        return WhitespaceImpl(text: text)
    }
}
