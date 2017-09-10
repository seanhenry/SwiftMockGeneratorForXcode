
class SwiftFileBuilder: SwiftElementBuilder {

    func build() -> SwiftFile {
        return SwiftFile(name: getName(), text: fileText, children: buildChildren(), offset: getOffset(), length: getLength())
    }
}
