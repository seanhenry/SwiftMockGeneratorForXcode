extension SameTypeRequirement {

    var rightType: Type {
        return children.reversed().first { $0 is Type } as? Type ?? TypeImpl.emptyType()
    }
}
