public class CaretUtil {

    public init() {}

    public func findElementUnderCaret(in element: Element, cursorOffset: Int64) -> Element? {
        let visitor = CaretFindingVisitor(offset: cursorOffset)
        element.accept(visitor)
        return visitor.result
    }

    private class CaretFindingVisitor: RecursiveElementVisitor {

        let offset: Int64
        var result: Element?

        init(offset: Int64) {
            self.offset = offset
        }

        override func visitElement(_ element: Element) {
            if element.offset <= offset
            && offset < element.offset + element.length {
                result = element
            }
            super.visitElement(element)
        }
    }
}
