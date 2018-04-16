class SwiftTupleType: SwiftType, TupleType {

    let elements: [TupleTypeElement]
    static let errorTupleType = SwiftTupleType(text: "", children: [], offset: -1, length: -1, elements: [])

    init(text: String, children: [Element], offset: Int64, length: Int64, elements: [TupleTypeElement]) {
        self.elements = elements
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
