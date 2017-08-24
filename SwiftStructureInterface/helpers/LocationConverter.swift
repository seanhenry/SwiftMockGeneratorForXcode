class LocationConverter {

    class func convert(line: Int, column: Int, in string: String) -> Int64? {
        var lines = string.components(separatedBy: .newlines)
        lines = lines.enumerated()
            .map { addNewlinesExceptLast(i: $0, string: $1, lineCount: lines.count) }
        if line < 0 || lines.count <= line || column < 0 {
            return nil
        }
        let characterCount = lines[0..<line].reduce(0, addCharacters)
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

    private class func addCharacters(count: Int64, string: String) -> Int64 {
        return count + Int64(string.characters.count)
    }
    
    private class func addNewlinesExceptLast(i: Int, string: String, lineCount: Int) -> String {
        if i == lineCount - 1 {
            return string
        }
        return string + "\n"
    }
}
