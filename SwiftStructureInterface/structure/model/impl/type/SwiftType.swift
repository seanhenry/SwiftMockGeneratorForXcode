class SwiftType: SwiftElement, Type {

    static let errorType = SwiftType(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitType(self)
    }
}
