class TypealiasDeclarationParser: DeclarationParser<Typealias> {

    override func parseDeclaration(offset: Int64) -> Typealias {
        let assignment = parseTypealiasAssignment()
        let length = convert(getPreviousEndLocation())! - offset
        return SwiftTypealias(text: getString(offset: offset, length: length)!, children: [], offset: offset, length: length, typeName: "")
    }
}
