class TypeAnnotationParser: Parser<TypeAnnotation> {

    override func parse(start: LineColumn) -> TypeAnnotation {
        return TypeAnnotationImpl(children: [
            try? parsePunctuation(.colon),
            parseWhitespace(),
            parseAttrs(),
            parseInout(),
            parseType()
        ])
    }

    private func parseInout() -> [Element]? {
        guard isNext(.inout) else { return nil }
        return [
            parseKeyword(),
            parseWhitespace()
        ]
    }

    private func parseAttrs() -> [Element]? {
        guard isNext(.at) else { return nil }
        return [
            parseAttributes(),
            parseWhitespace()
        ]
    }
}
