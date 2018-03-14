class SwiftParameter: SwiftElement, Parameter {

    static let errorParameter = SwiftParameter(text: "", children: [], offset: -1, length: -1, type: SwiftElement.errorElement)
    let type: Element
    let externalParameterName: String?
    let localParameterName: String

    convenience init(text: String, children: [Element], offset: Int64, length: Int64, type: Element) {
        self.init(text: text, children: children, offset: offset, length: length, externalParameterName: nil, localParameterName: "", type: type)
    }

    init(text: String, children: [Element], offset: Int64, length: Int64, externalParameterName: String?, localParameterName: String, type: Element) {
        self.externalParameterName = externalParameterName
        self.localParameterName = localParameterName
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitParameter(self)
    }
}
