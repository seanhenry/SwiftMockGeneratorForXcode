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

    class func convert(caretOffset: Int64, in string: String) -> (line: Int, column: Int)? {
        let offset = Int(caretOffset)
        if caretOffset < 0 || string.characters.count < offset {
            return nil
        }
        let lines = string.components(separatedBy: .newlines)
        let newLineCharacterCount = 1
        var lineCounter = 0
        var remainingOffset = offset
        for line in lines {
            let lineCharacterCount = line.characters.count + newLineCharacterCount
            if remainingOffset - lineCharacterCount < 0 {
                break
            }
            remainingOffset -= lineCharacterCount
            lineCounter += 1
        }
        return (lineCounter, remainingOffset)
    }

    private class func addCharactersAndNewline(count: Int64, string: String) -> Int64 {
        let newlineCount: Int64 = 1
        return count + Int64(string.characters.count) + newlineCount
    }
}
