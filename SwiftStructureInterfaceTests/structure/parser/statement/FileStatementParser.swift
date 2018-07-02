class FileStatementParser: StatementParser {

    override func isEndOfParsing() -> Bool {
        return isNext(.eof)
    }
}
