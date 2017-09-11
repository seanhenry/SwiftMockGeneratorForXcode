import SourceKittenFramework

class SwiftTypeElementBuilder: BodySwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String, bodyOffset: Int64, bodyLength: Int64) -> Element? {
        return SwiftTypeElement(name: name, text: text, children: buildChildren(), inheritedTypes: getInheritedTypes(), offset: offset, length: length, bodyOffset: bodyOffset, bodyLength: bodyLength)
    }

    private func getInheritedTypes() -> [SwiftInheritedType] {
        guard let typeData = data["key.inheritedtypes"] as? [[String: SourceKitRepresentable]],
              let declarationText = getDeclarationText() else { return [] }
        let typesTextStrings = getInheritedTypesStrings(declarationText: declarationText)
        let offsetAndLengths = getInheritedTypesTextOffsets(typeTexts: typesTextStrings, declarationText: declarationText)
        return augmentAndBuildInheritedTypes(offsetAndLengths: offsetAndLengths, typeData: typeData)
    }

    private func augmentAndBuildInheritedTypes(offsetAndLengths: [(offset: Int64, length: Int64)], typeData: [[String: SourceKitRepresentable]]) -> [SwiftInheritedType] {
        return zip(offsetAndLengths, typeData).flatMap { (offsetAndLength, data) in
            var newData = data
            newData["key.kind"] = SwiftInheritedTypeBuilder.kind
            newData["key.offset"] = offsetAndLength.0
            newData["key.length"] = offsetAndLength.1
            return SwiftInheritedTypeBuilder(data: newData, fileText: fileText).build() as? SwiftInheritedType
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
        var runningOffset = getOffset()! + Int64(typeClauseOffset)
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
