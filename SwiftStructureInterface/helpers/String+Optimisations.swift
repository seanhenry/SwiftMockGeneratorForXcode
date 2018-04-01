extension String {

    public func getLines() -> [String] {
        return components(separatedBy: .newlines)
    }
}
