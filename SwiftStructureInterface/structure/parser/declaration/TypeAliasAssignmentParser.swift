class TypealiasAssignmentParser: Parser<Element> {

    override func parse() -> Element {
        let start = getCurrentStartLocation()
        guard isNext(.assignmentOperator) else {
            return SwiftElement.errorElement
        }
        advance()
        _ = parseTypeIdentifier()
        let offset = convert(start)!
        let length = convert(getCurrentEndLocation())! - offset
        return SwiftElement(text: getString(offset: offset, length: length)!, children: [], offset: offset, length: length)
    }
}
