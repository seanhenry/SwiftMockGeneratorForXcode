class TypeAnnotationParser: Parser<TypeAnnotation> {

    override func parse(start: LineColumn) -> TypeAnnotation {
        advance(if: .colon)
        let attributes = parseAttributes()
        let isInout = parseInout()
        let type = parseType()
        return createElement(start: start) { offset, length, text in
            SwiftTypeAnnotation(text: text,
                children: [type],
                offset: offset,
                length: length,
                attributes: attributes,
                isInout: isInout,
                type: type)
        } ?? SwiftTypeAnnotation.errorTypeAnnotation
    }

    private func parseInout() -> Bool {
        let isInout = isNext(.inout)
        advance(if: .inout)
        return isInout
    }
}
