class SwiftTypeAnnotation: SwiftElement, TypeAnnotation {

    let attributes: [String]
    let isInout: Bool
    let type: Element

    static let errorTypeAnnotation = SwiftTypeAnnotation(text: "", children: [], offset: -1, length: -1, attributes: [], isInout: false, type: SwiftElement.errorElement)

    init(text: String, children: [Element], offset: Int64, length: Int64, attributes: [String], isInout: Bool, type: Element) {
        self.attributes = attributes
        self.isInout = isInout
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
