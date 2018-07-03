public class CaretUtil {

    public init() {}

    public func findElementUnderCaret<T>(in element: Element, cursorOffset: Int, type: T.Type) -> T? {
        let visitor = CaretFindingVisitor(offset: cursorOffset)
        element.accept(visitor)
        if let result = visitor.result {
            return ElementTreeUtil().findParent(type, from: result)
        }
        return nil
    }

    private class CaretFindingVisitor: RecursiveElementVisitor {

        var offset = 0
        let targetOffset: Int
        var result: Element?

        init(offset: Int) {
            self.targetOffset = offset
        }

        override func visitLeafNode(_ element: LeafNode) {
            let length = element.text.count
            if offset <= targetOffset && targetOffset < offset + length {
                result = element
            }
            offset += length
        }
    }
}
