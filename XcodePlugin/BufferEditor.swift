class BufferEditor {

    func delete(from: Int, length: Int, in lines: NSMutableArray) {
        if length <= 0 || from < 0 || (from + length) > lines.count {
            return
        }
        lines.removeObjects(in: NSMakeRange(from, length))
    }

    func insert(_ toInsert: [String], into lines: NSMutableArray, at: Int) {
        if toInsert.isEmpty || at < 0 || at > lines.count {
            return
        }
        toInsert.reversed().forEach { lines.insert($0, at: at) }
    }
}
