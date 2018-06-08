class TypeAnnotationWrapper<T: TypeAnnotation>: ElementWrapper<T>, TypeAnnotation {

    var attributes: [String] {
        return managed.attributes
    }

    var isInout: Bool {
        return managed.isInout
    }

    var type: Type {
        return managed.type
    }
}
