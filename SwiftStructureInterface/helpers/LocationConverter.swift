class LocationConverter {

    class func convert(line: Int, column: Int, in string: String) -> Int64? {
        let lines = string.components(separatedBy: .newlines)
        if line < 0 || lines.count <= line || column < 0 {
            return nil
        }
        let characterCount = lines[0..<line].reduce(0, addCharactersAndNewline)
        if column < lines[line].characters.count {
            return characterCount + Int64(column)
        }
        return nil
    }

    private class func addCharactersAndNewline(count: Int64, string: String) -> Int64 {
        let newlineCount: Int64 = 1
        return count + Int64(string.characters.count) + newlineCount
    }
}
