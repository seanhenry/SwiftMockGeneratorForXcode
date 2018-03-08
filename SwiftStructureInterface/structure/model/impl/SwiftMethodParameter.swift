class SwiftMethodParameter: SwiftElement, MethodParameter {

    static let errorMethodParameter = SwiftMethodParameter(text: "", children: [], offset: -1, length: -1, type: SwiftElement.errorElement)
    let type: Element

    init(text: String, children: [Element], offset: Int64, length: Int64, type: Element) {
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
