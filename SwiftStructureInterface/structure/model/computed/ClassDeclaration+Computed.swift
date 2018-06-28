extension ClassDeclaration {

    var isFinal: Bool {
        return declarationModifiers.contains { $0.text == Keywords.final }
    }
}
