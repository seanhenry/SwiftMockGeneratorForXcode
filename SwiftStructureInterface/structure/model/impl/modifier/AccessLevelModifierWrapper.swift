class AccessLevelModifierWrapper: ElementWrapper, AccessLevelModifier {

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitAccessLevelModifier(self)
    }
}
