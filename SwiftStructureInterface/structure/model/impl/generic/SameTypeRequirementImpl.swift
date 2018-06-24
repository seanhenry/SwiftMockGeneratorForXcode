class SameTypeRequirementImpl: RequirementImpl, SameTypeRequirement {

    var rightType: Type {
        return children.reversed().first { $0 is Type } as? Type ?? TypeImpl.emptyType
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitSameTypeRequirement(self)
    }
}
