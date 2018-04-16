class SwiftParameter: SwiftElement, Parameter {

    static let errorParameter = SwiftParameter(text: "", children: [], offset: -1, length: -1, externalParameterName: nil, localParameterName: "", typeAnnotation: SwiftTypeAnnotation.errorTypeAnnotation)
    let typeAnnotation: TypeAnnotation
    let externalParameterName: String?
    let localParameterName: String

    convenience init(text: String, children: [Element], offset: Int64, length: Int64, type: Element) {
        let typeElement = SwiftType(text: type.text, children: type.children, offset: type.offset, length: type.length)
        let typeAnnotation = SwiftTypeAnnotation(text: typeElement.text, children: [typeElement], offset: 0, length: 0, attributes: [], isInout: false, type: typeElement)
        self.init(text: text, children: children, offset: offset, length: length, externalParameterName: nil, localParameterName: "", typeAnnotation: typeAnnotation)
    }

    init(text: String, children: [Element], offset: Int64, length: Int64, externalParameterName: String?, localParameterName: String, typeAnnotation: TypeAnnotation) {
        self.externalParameterName = externalParameterName
        self.localParameterName = localParameterName
        self.typeAnnotation = typeAnnotation
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitParameter(self)
    }
}
