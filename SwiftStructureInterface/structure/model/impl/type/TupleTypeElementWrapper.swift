class TupleTypeElementWrapper<T: TupleTypeElement>: ElementWrapper<T>, TupleTypeElement {

    var label: String? {
        return label
    }

    var typeAnnotation: TypeAnnotation {
        return typeAnnotation
    }
}
