class TypealiasDeclarationParser: DeclarationParser<Typealias> {

    override func parseDeclaration(offset: Int64) -> Typealias {
        var name = ""
        tryToAppendIdentifier(to: &name)
        _ = parseGenericParameterClause()
        let assignment = parseTypealiasAssignment()
        let length = convert(getPreviousEndLocation())! - offset
        return SwiftTypealias(
            text: getString(offset: offset, length: length)!,
            children: [assignment],
            offset: offset,
            length: length,
            name: name,
            typealiasAssignment: assignment)
    }
}
