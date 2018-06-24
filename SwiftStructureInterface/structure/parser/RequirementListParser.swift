class RequirementListParser: Parser<RequirementList> {

    override func parse(start: LineColumn) -> RequirementList {
        var children = [Element?]()
        children.append(parseRequirement())
        while isNext(.comma) {
            children.append(parseWhitespace())
            children.append(try? parsePunctuation(.comma))
            children.append(parseWhitespace())
            children.append(parseRequirement())
        }
        return RequirementListImpl(children: children)
    }

    private func parseRequirement() -> Requirement {
        let children: [Element] = [
            parseType(),
            parseWhitespace()
        ]
        return finishParsingRequirement(children)
    }

    private func finishParsingRequirement(_ children: [Element]) -> Requirement {
        if isConformanceRequirement() {
            return ConformanceRequirementImpl(children: children + [
                try? parsePunctuation(.colon),
                parseWhitespace(),
                parseType()
            ])
        } else {
            return SameTypeRequirementImpl(children: children + [
                try? parseBinaryOperator("=="),
                parseWhitespace(),
                parseType()
            ])
        }
    }

    private func isConformanceRequirement() -> Bool {
        return isNext(.colon)
    }
}
