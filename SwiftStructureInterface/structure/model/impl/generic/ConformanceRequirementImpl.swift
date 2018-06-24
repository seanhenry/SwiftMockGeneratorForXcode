class ConformanceRequirementImpl: RequirementImpl, ConformanceRequirement {

    var rightTypeIdentifier: TypeIdentifier {
        return children.reversed().first { $0 is TypeIdentifier } as? TypeIdentifier ?? TypeIdentifierImpl.emptyTypeIdentifier
    }
    var rightProtocolCompositionType: ProtocolCompositionType {
        return children.first { $0 is ProtocolCompositionType } as? ProtocolCompositionType ?? ProtocolCompositionTypeImpl.emptyProtocolCompositionType
    }

    override init(children: [Any?]) {
        super.init(children: children)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitConformanceRequirement(self)
    }
}
