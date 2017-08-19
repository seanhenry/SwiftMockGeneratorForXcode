import SourceKittenFramework

class StructureBuilder {

    private let text: String
    private let originalData: [String: SourceKitRepresentable]
    private var data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], text: String) {
        self.originalData = data
        self.data = data
        self.text = text
    }

    func build() -> Element {
        guard isFileData() else {
            return buildElement(data)
        }
        return buildSwiftFile()
    }

    private func isFileData() -> Bool {
        return data["key.diagnostic_stage"] != nil
    }

    private func buildElement(_ data: [String: SourceKitRepresentable]) -> Element {
        self.data = data
        guard let kind = data["key.kind"] as? String else {
            return buildSwiftElement()
        }
        switch kind {
        case "source.lang.swift.decl.protocol",
             "source.lang.swift.decl.class":
            return buildSwiftTypeElement()
        default:
            return buildSwiftElement()
        }
    }

    private func buildSwiftFile() -> SwiftFile {
        return SwiftFile(name: getName(), text: text, children: buildChildren(), offset: getOffset(), length: getLength())
    }

    private func buildSwiftElement() -> SwiftElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        return SwiftElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length)
    }

    private func buildSwiftTypeElement() -> SwiftTypeElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        return SwiftTypeElement(name: getName(), text: text, children: buildChildren(), inheritedTypes: getInheritedTypes(), offset: offset, length: length, bodyOffset: getBodyOffset(), bodyLength: getBodyLength())
    }

    private func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            StructureBuilder(data: $0, text: text).build()
        } ?? []
    }

    private func getText(offset: Int64, length: Int64) -> String {
        if offset < 0 || length < 0 {
            return ""
        }
        let start = text.index(text.startIndex, offsetBy: Int(offset))
        let end = text.index(start, offsetBy: Int(length))
        return text[start..<end]
    }

    private func getSubStructure() -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }

    private func getName() -> String {
        let name = (data["key.name"] as? String)
        return name?.components(separatedBy: "(").first ?? ""
    }

    private func getOffset() -> Int64 {
        return (data["key.offset"] as? Int64) ?? -1
    }

    private func getLength() -> Int64 {
        return (data["key.length"] as? Int64) ?? -1
    }

    private func getBodyOffset() -> Int64 {
        return (data["key.bodyoffset"] as? Int64) ?? -1
    }

    private func getBodyLength() -> Int64 {
        return (data["key.bodylength"] as? Int64) ?? -1
    }

    // MARK: - InheritedType

    private func getInheritedTypes() -> [Element] {
        guard let typeData = data["key.inheritedtypes"] as? [[String: SourceKitRepresentable]] else { return [] }
        let declarationText = getDeclarationText()
        let typesTextStrings = getInheritedTypesStrings(declarationText: declarationText)
        let offsetAndLengths = getInheritedTypesTextOffsets(typesTextStrings: typesTextStrings, declarationText: declarationText)
        return augmentAndBuildInheritedTypes(offsetAndLengths: offsetAndLengths, typeData: typeData)
    }

    private func augmentAndBuildInheritedTypes(offsetAndLengths: [(offset: Int64, length: Int64)], typeData: [[String: SourceKitRepresentable]]) -> [Element] {
        return zip(offsetAndLengths, typeData).map { (offsetAndLength, data) in
            var newData = data
            newData["key.offset"] = offsetAndLength.0
            newData["key.length"] = offsetAndLength.1
            return StructureBuilder(data: newData, text: text).build()
        }
    }

    private func getInheritedTypesTextOffsets(typesTextStrings: [String], declarationText: String) -> [(offset: Int64, length: Int64)] {
        return typesTextStrings.map { type in
            let splitDeclaration = self.splitDeclaration(declarationText)
            let classPart = splitDeclaration[0] + ":"
            let inheritedPart = splitDeclaration[1]
            let range = inheritedPart.range(of: type)!
            return (getOffset() + Int64(classPart.characters.count) + Int64(declarationText.distance(from: inheritedPart.startIndex, to: range.lowerBound)), Int64(inheritedPart.distance(from: range.lowerBound, to: range.upperBound)))
        }
    }

    private func getInheritedTypesStrings(declarationText: String) -> [String] {
        let inheritedTypesString = splitDeclaration(declarationText)
        var typesTextStrings = [String]()
        if inheritedTypesString.count > 1 {
            typesTextStrings = inheritedTypesString[1]
                .replacingOccurrences(of: " ", with: "")
                .components(separatedBy: ",")
        }
        return typesTextStrings
    }

    private func splitDeclaration(_ declarationText: String) -> [String] {
        return declarationText.components(separatedBy: CharacterSet(charactersIn: ":{"))
    }

    private func getDeclarationText() -> String {
        let offset = getOffset()
        let bodyOffset = getStatementEndOffset()
        let declarationText = getText(offset: offset, length: bodyOffset - offset)
        return declarationText
    }

    private func getStatementEndOffset() -> Int64 {
        var bodyOffset = getBodyOffset() - 1
        if bodyOffset < 0 {
            bodyOffset = getLength()
        }
        return bodyOffset
    }
}
