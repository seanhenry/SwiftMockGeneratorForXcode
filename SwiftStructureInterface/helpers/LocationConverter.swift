class LocationConverter {

    class func convert(line: Int, column: Int, in string: String) -> Int? {
        let lines = string.components(separatedBy: .newlines)
        if line < 0 || lines.count <= line || column < 0 {
            return nil
        }
        let characterCount = lines[0..<line].reduce(0, addCharactersAndNewline)
        if column < lines[line].characters.count {
            return characterCount + column
        }
        return nil
    }

    private class func addCharactersAndNewline(count: Int, string: String) -> Int {
        let newlineCount = 1
        return count + string.characters.count + newlineCount
    }
}
