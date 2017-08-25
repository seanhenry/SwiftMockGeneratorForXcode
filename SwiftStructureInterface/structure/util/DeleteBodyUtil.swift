import SourceKittenFramework

class DeleteBodyUtil {

    func deleteClassBody(from element: Element) -> (file: Element, element: Element)? {
        guard let fileString = getFileStringRemovingBody(from: element) else { return nil }
        let file = StructureBuilder(data: Structure(file: SourceKittenFramework.File(contents: fileString)).dictionary, text: fileString).build()
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
                bodyOffset + bodyLength < fileText.characters.count else { return }
            let bodyStartIndex = fileText.index(fileText.startIndex, offsetBy: bodyOffset)
            let bodyEndIndex = fileText.index(bodyStartIndex, offsetBy: bodyLength)
            fileString = fileText.substring(to: bodyStartIndex) + "\n" + fileText.substring(from: bodyEndIndex)
        }

        func visit(_ element: SwiftFile) {
        }

        func visit(_ element: SwiftMethodElement) {
        }
    }
}
