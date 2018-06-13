class TypeDeclarationWrapper: ElementWrapper, TypeDeclaration {

    private let managedTypeDeclaration: TypeDeclaration

    init(_ element: TypeDeclaration) {
        self.managedTypeDeclaration = element
        super.init(element)
    }

    var accessLevelModifier: AccessLevelModifier {
        return wrap(managedTypeDeclaration.accessLevelModifier)
    }

    var inheritedTypes: [Element] {
        return managedTypeDeclaration.inheritedTypes
    }

    var name: String {
        return managedTypeDeclaration.name
    }

    var bodyOffset: Int64 {
        return managedTypeDeclaration.bodyOffset
    }

    var bodyLength: Int64 {
        return managedTypeDeclaration.bodyLength
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeDeclaration(self)
    }
}
