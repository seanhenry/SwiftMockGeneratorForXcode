class ParameterWrapper<T: Parameter>: ElementWrapper<T>, Parameter {
    
    var typeAnnotation: TypeAnnotation {
        return typeAnnotation
    }
    
    var externalParameterName: String? {
        return externalParameterName
    }
    
    var localParameterName: String {
        return localParameterName
    }
}
