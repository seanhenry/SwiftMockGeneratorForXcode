class SwiftParameter: SwiftElement, Parameter {

    static let errorParameter = SwiftParameter(text: "", children: [], offset: -1, length: -1, type: SwiftType.errorType)
    let type: Type
    let externalParameterName: String?
    let localParameterName: String

    convenience init(text: String, children: [Element], offset: Int64, length: Int64, type: Type) {
        self.init(text: text, children: children, offset: offset, length: length, externalParameterName: nil, localParameterName: "", type: type)
    }

    init(text: String, children: [Element], offset: Int64, length: Int64, externalParameterName: String?, localParameterName: String, type: Type) {
        self.externalParameterName = externalParameterName
        self.localParameterName = localParameterName
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitParameter(self)
    }
}
