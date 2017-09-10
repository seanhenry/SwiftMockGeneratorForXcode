import SourceKittenFramework

class DeleteBodyUtil {

    func deleteClassBody(from element: Element) -> (file: Element, element: Element)? {
        guard let fileString = getFileStringRemovingBody(from: element) else { return nil }
        let file = SKElementFactory().build(from: fileString)
        let elementEquivalent = CaretUtil().findElementUnderCaret(in: file, cursorOffset: element.offset)!
        return (file, elementEquivalent)
    }

    private func getFileStringRemovingBody(from element: Element) -> String? {
        let visitor = Visitor()
        element.accept(visitor)
        return visitor.fileString
    }

    private class Visitor: ElementVisitor {

        var fileString: String?

        func visit(_ element: SwiftElement) {
        }

        func visit(_ element: SwiftTypeElement) {
            let bodyOffset = Int(element.bodyOffset)
            let bodyLength = Int(element.bodyLength)
            guard let fileText = element.file?.text,
                bodyOffset > 0,
                bodyOffset + bodyLength < fileText.utf8.count else { return }
            let fileUTF8Text = fileText.utf8
            let bodyStartIndex = fileUTF8Text.index(fileUTF8Text.startIndex, offsetBy: bodyOffset)
            let bodyEndIndex = fileUTF8Text.index(bodyStartIndex, offsetBy: bodyLength)
            let beforeString = String(fileUTF8Text[fileUTF8Text.startIndex..<bodyStartIndex])!
            let afterString = String(fileUTF8Text[bodyEndIndex..<fileUTF8Text.endIndex])!
            fileString = beforeString + "\n" + afterString
        }

        func visit(_ element: SwiftFile) {
        }

        func visit(_ element: SwiftMethodElement) {
        }

        func visit(_ element: SwiftPropertyElement) {
        }
    }
}
