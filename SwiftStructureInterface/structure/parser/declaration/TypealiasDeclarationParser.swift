class TypealiasDeclarationParser: DeclarationParser<Typealias> {

    override func parseDeclaration(offset: Int64) -> Typealias {
        var name = ""
        tryToAppendIdentifier(to: &name)
        _ = parseGenericParameterClause()
        let assignment = parseTypealiasAssignment()
        return createElement(offset: offset) { length, text in
            return SwiftTypealias(
                text: text,
                children: [assignment],
                offset: offset,
                length: length,
                name: name,
                typealiasAssignment: assignment)
        } ?? SwiftTypealias.errorTypealias
    }
}
