class TypealiasDeclarationParser: DeclarationParser<Typealias> {

    override func parseDeclaration(start: LineColumn) -> Typealias {
        var name = ""
        tryToAppendIdentifier(to: &name)
        _ = parseGenericParameterClause()
        let assignment = parseTypealiasAssignment()
        return createElement(start: start) { offset, length, text in
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
