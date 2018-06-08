class TypeDeclarationWrapper<T: TypeDeclaration>: ElementWrapper<T>, TypeDeclaration {

    var accessLevelModifier: AccessLevelModifier {
        return managed.accessLevelModifier
    }

    var inheritedTypes: [Element] {
        return managed.inheritedTypes
    }

    var name: String {
        return managed.name
    }

    var bodyOffset: Int64 {
        return managed.bodyOffset
    }

    var bodyLength: Int64 {
        return managed.bodyLength
    }
}
