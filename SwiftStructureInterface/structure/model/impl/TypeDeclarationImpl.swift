import SourceKittenFramework

class TypeDeclarationImpl: ElementImpl, TypeDeclaration {

    static let errorTypeDeclaration = TypeDeclarationImpl(name: "", text: "", children: [], inheritedTypes: [], offset: -1, length: -1, bodyOffset: -1, bodyLength: -1, accessLevelModifier: AccessLevelModifierImpl.emptyAccessLevelModifier)
    let name: String
    let inheritedTypes: [Element]
    let bodyOffset: Int64
    let bodyLength: Int64
    let accessLevelModifier: AccessLevelModifier

    init(name: String, text: String, children: [Element], inheritedTypes: [Element], offset: Int64, length: Int64, bodyOffset: Int64, bodyLength: Int64, accessLevelModifier: AccessLevelModifier) {
        self.name = name
        self.inheritedTypes = inheritedTypes
        self.bodyOffset = bodyOffset
        self.bodyLength = bodyLength
        self.accessLevelModifier = accessLevelModifier
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeDeclaration(self)
    }
}
