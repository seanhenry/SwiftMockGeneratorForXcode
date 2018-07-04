class FindElementLocation {

    enum Encoding {
        case utf32, utf8
    }

    func findLineColumnOffset(_ element: Element, encoding: Encoding = .utf32) -> (line: Int, column: Int, offset: Int) {
        let visitor = Visitor(element, encoding)
        element.file!.accept(visitor)
        return (visitor.line, visitor.column, visitor.offset)
    }

    func findLineColumn(_ element: Element, encoding: Encoding = .utf32) -> (line: Int, column: Int) {
        let (line, column, _) = findLineColumnOffset(element, encoding: encoding)
        return (line, column)
    }

    func findOffset(_ element: Element, encoding: Encoding = .utf32) -> Int {
        return findLineColumnOffset(element, encoding: encoding).offset
    }

    private class Visitor: RecursiveElementVisitor {

        var line = 0
        var column = 0
        var offset = 0
        var isFound = false
        var elementToFind: Element
        var calculate: ((Element) -> ())!
        private let utf8Newline: UInt8 = "\n".utf8.first!
        private let utf8CarriageReturn: UInt8 = "\r".utf8.first!

        init(_ element: Element, _ encoding: Encoding) {
            elementToFind = element
            super.init()
            switch encoding {
            case .utf8:
                calculate = calculateUTF8
            case .utf32:
                calculate = calculateUTF32
            }
        }

        func calculateUTF8(_ element: Element) {
            for c in element.text.utf8 {
                if c == utf8Newline || c == utf8CarriageReturn {
                    line += 1
                    column = 0
                } else {
                    column += 1
                }
                offset += 1
            }
        }

        func calculateUTF32(_ element: Element) {
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

        override func visitLeafNode(_ element: LeafNode) {
            if isFound {
                return
            }
            calculate(element)
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
