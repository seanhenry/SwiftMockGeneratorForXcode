import SourceKittenFramework

class SwiftTypeElementBuilder: SwiftElementBuilder {

    func build() -> SwiftTypeElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        return SwiftTypeElement(name: getName(), text: text, children: buildChildren(), inheritedTypes: getInheritedTypes(), offset: offset, length: length, bodyOffset: getBodyOffset(), bodyLength: getBodyLength())
    }

    private func getInheritedTypes() -> [Element] {
        guard let typeData = data["key.inheritedtypes"] as? [[String: SourceKitRepresentable]] else { return [] }
        let declarationText = getDeclarationText()
        let typesTextStrings = getInheritedTypesStrings(declarationText: declarationText)
        let offsetAndLengths = getInheritedTypesTextOffsets(typeTexts: typesTextStrings, declarationText: declarationText)
        return augmentAndBuildInheritedTypes(offsetAndLengths: offsetAndLengths, typeData: typeData)
    }

    private func augmentAndBuildInheritedTypes(offsetAndLengths: [(offset: Int64, length: Int64)], typeData: [[String: SourceKitRepresentable]]) -> [Element] {
        return zip(offsetAndLengths, typeData).map { (offsetAndLength, data) in
            var newData = data
            newData["key.offset"] = offsetAndLength.0
            newData["key.length"] = offsetAndLength.1
            return SKElementFactory().build(data: newData, fileText: fileText)
        }
    }

    private func getInheritedTypesTextOffsets(typeTexts: [String], declarationText: String) -> [(offset: Int64, length: Int64)] {
        let splitDeclaration = self.splitDeclaration(declarationText)
        guard splitDeclaration.count > 1 else { return [] }
        let classPart = splitDeclaration[0] + ":"
        let inheritedTypeNames = splitDeclaration[1].components(separatedBy: ",").map { $0 + "," }
        return getOffsets(fromTypes: typeTexts, typeNames: inheritedTypeNames, typeClauseOffset: classPart.utf8.count, in: declarationText)
    }

    private func getOffsets(fromTypes typeTexts: [String], typeNames: [String], typeClauseOffset: Int, in declarationText: String) -> [(offset: Int64, length: Int64)] {
        var runningOffset = getOffset() + Int64(typeClauseOffset)
        return typeTexts.enumerated().map { i, type in
            let inheritedPart = typeNames[i]
            defer { runningOffset += Int64(inheritedPart.utf8.count) }
            let range = inheritedPart.range(of: type)!
            let startOffset = Int64(declarationText.distance(from: inheritedPart.startIndex, to: range.lowerBound))
            let length = Int64(inheritedPart.distance(from: range.lowerBound, to: range.upperBound))
            return (runningOffset + startOffset, length)
        }
    }

    private func getInheritedTypesStrings(declarationText: String) -> [String] {
        let inheritedTypesString = splitDeclaration(declarationText)
        var typesTextStrings = [String]()
        if inheritedTypesString.count > 1 {
            typesTextStrings = inheritedTypesString[1]
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "\n", with: "")
                .components(separatedBy: ",")
        }
        return typesTextStrings
    }

    private func splitDeclaration(_ declarationText: String) -> [String] {
        return declarationText.components(separatedBy: CharacterSet(charactersIn: ":{"))
    }
}
