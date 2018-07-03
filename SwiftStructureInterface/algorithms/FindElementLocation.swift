class FindElementLocation {

    func findLineColumnOffset(_ element: Element) -> (line: Int, column: Int, offset: Int) {
        let visitor = Visitor(element)
        element.file!.accept(visitor)
        return (visitor.line, visitor.column, visitor.offset)
    }

    func findLineColumn(_ element: Element) -> (line: Int, column: Int) {
        let (line, column, _) = findLineColumnOffset(element)
        return (line, column)
    }

    func findOffset(_ element: Element) -> Int {
        return findLineColumnOffset(element).offset
    }

    private class Visitor: RecursiveElementVisitor {

        var line = 0
        var column = 0
        var offset = 0
        var isFound = false
        let elementToFind: Element

        init(_ element: Element) {
            elementToFind = element
        }

        override func visitLeafNode(_ element: LeafNode) {
            if isFound {
                return
            }
            for c in element.text {
                if c == "\n" || c == "\r" {
                    line += 1
                    column = 0
                } else {
                    column += 1
                }
                offset += 1
            }
        }

        override func visitElement(_ element: Element) {
            if element.isIdentical(to: elementToFind) {
                isFound = true
                return
            }
            super.visitElement(element)
        }
    }
}
