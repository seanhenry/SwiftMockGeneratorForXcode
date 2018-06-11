class AccessLevelModifierImpl: ElementImpl, AccessLevelModifier {
    public static let emptyAccessLevelModifier = AccessLevelModifierImpl(text: "", children: [], offset: 0, length: 0)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitAccessLevelModifier(self)
    }
}
