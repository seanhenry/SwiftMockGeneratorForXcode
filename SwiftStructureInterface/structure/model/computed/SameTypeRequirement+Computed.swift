extension SameTypeRequirement {

    var rightType: Type {
        return last(Type.self) ?? TypeImpl.emptyType()
    }
}
