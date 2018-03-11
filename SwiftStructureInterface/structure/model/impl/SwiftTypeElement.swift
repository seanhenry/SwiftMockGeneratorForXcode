import SourceKittenFramework

class SwiftTypeElement: SwiftElement, TypeDeclaration {

    let name: String
    let inheritedTypes: [Element]
    let bodyOffset: Int64
    let bodyLength: Int64

    init(name: String, text: String, children: [Element], inheritedTypes: [Element], offset: Int64, length: Int64, bodyOffset: Int64, bodyLength: Int64) {
        self.name = name
        self.inheritedTypes = inheritedTypes
        self.bodyOffset = bodyOffset
        self.bodyLength = bodyLength
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeDeclaration(self)
    }
}
