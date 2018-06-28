extension Parameter {

    public var externalParameterName: String? {
        let identifiers = self.identifiers
        if identifiers.count == 2 {
            return identifiers.first?.text
        }
        return children.first { $0.text == "_" }?.text
    }

    public var localParameterName: String {
        return last(Identifier.self)?.text ?? ""
    }

    private var identifiers: [Identifier] {
        return children.compactMap { $0 as? Identifier }
    }
}
