class ProtocolCompositionParser: Parser<String> {

    class Error: Swift.Error {}

    override func parse() -> String {
        var composition = ""
        let id = setCheckPoint()
        do {
            try appendIdentifier(to: &composition)
            try appendCompositionRHS(to: &composition)
            repeat {
                try? appendCompositionRHS(to: &composition)
            } while isNextAmpBinaryOperator()
        } catch {
            restoreCheckPoint(id)
            composition = ""
        }
        return composition
    }

    private func appendCompositionRHS(to string: inout String) throws {
        try appendAmpBinaryOperator(to: &string)
        try appendIdentifier(to: &string)
    }

    private func appendAmpBinaryOperator(to string: inout String) throws {
        if isNextAmpBinaryOperator() {
            advance()
            string.append(" & ")
        } else {
            throw Error()
        }
    }

    private func isNextAmpBinaryOperator() -> Bool {
        if case let .binaryOperator(op) = peekAtNextKind(), op == "&" {
            return true
        }
        return false
    }
}
