class ParameterWrapper: ElementWrapper, Parameter {

    let managedParameter: Parameter

    init(_ element: Parameter) {
        managedParameter = element
        super.init(element)
    }
    
    var typeAnnotation: TypeAnnotation {
        return wrap(managedParameter.typeAnnotation)
    }
    
    var externalParameterName: String? {
        return managedParameter.externalParameterName
    }
    
    var localParameterName: String {
        return managedParameter.localParameterName
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitParameter(self)
    }
}
