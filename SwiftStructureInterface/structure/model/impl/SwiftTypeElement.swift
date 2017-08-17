import SourceKittenFramework

class SwiftTypeElement: SwiftElement, TypeDeclaration, CodeBlockContainer {

    let inheritedTypes: [Element]
    let bodyOffset: Int64
    let bodyLength: Int64

    init(name: String, children: [Element], inheritedTypes: [Element], offset: Int64, length: Int64, bodyOffset: Int64, bodyLength: Int64) {
        self.inheritedTypes = inheritedTypes
        self.bodyOffset = bodyOffset
        self.bodyLength = bodyLength
        super.init(name: name, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
