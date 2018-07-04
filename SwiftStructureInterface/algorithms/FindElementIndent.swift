class FindElementIndent {

    func find(_ element: Element) -> String {
        let visitor = Visitor(element)
        var target = element
        while let parent = target.parent, !visitor.isIndentFound {
            parent.children.reversed().forEach { $0.accept(visitor) }
            target = parent
        }
        return visitor.indent
    }

    private class Visitor: ElementVisitor {

        var indent = ""
        var isElementFound = false
        var isIndentFound = false
        let elementToFind: Element

        init(_ element: Element) {
            elementToFind = element
        }

        override func visitWhitespace(_ element: Whitespace) {
            if !isElementFound || isIndentFound {
                return
            }
            let reversedText = element.text.replacingOccurrences(of: "\r", with: "\n").reversed()
            guard let index = reversedText.index(of: "\n") else {
                indent = element.text
                return
            }
            isIndentFound = true
            indent = String(reversedText[reversedText.startIndex..<index])
        }

        override func visitElement(_ element: Element) {
            if element.isIdentical(to: elementToFind) {
                isElementFound = true
                return
            }
        }
    }
}
