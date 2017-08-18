class CaretUtil {

    func findElementUnderCaret(in element: Element, cursorOffset: Int64) -> Element? {
        let visitor = CaretFindingVisitor(offset: cursorOffset)
        element.accept(RecursiveElementVisitor(visitor: visitor))
        return visitor.result
    }

    private class CaretFindingVisitor: ElementVisitor {

        let offset: Int64
        var result: Element?

        init(offset: Int64) {
            self.offset = offset
        }

        func visit(_ element: SwiftElement) {
            if element.offset <= offset
            && offset < element.offset + element.length {
                result = element
            }
        }

        func visit(_ element: SwiftTypeElement) {
        }

        func visit(_ element: SwiftFile) {
        }
    }
}
