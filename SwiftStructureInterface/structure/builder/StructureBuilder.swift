import SourceKittenFramework

class SwiftElementBuilder {

    let fileText: String
    var data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func getText(offset: Int64, length: Int64) -> String {
        let utf8 = fileText.utf8
        let lastTextIndex = Int64(utf8.count)
        if offset < 0 || length < 0 || lastTextIndex < offset + length {
            return ""
        }
        let start = utf8.index(utf8.startIndex, offsetBy: Int(offset))
        let end = utf8.index(start, offsetBy: Int(length))
        return String(utf8[start..<end])!
    }

    func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            StructureBuilder(data: $0, fileText: fileText).build()
        } ?? []
    }

    func getSubStructure() -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }

    func getName() -> String {
        let name = (data["key.name"] as? String)
        return name?.components(separatedBy: "(").first ?? ""
    }

    func getOffset() -> Int64 {
        return (data["key.offset"] as? Int64) ?? -1
    }

    func getLength() -> Int64 {
        return (data["key.length"] as? Int64) ?? -1
    }

    // TODO: move these into a bodyoffset/legnth place?

    func getDeclarationText() -> String {
        let offset = getOffset()
        let bodyOffset = getStatementEndOffset()
        return getText(offset: offset, length: bodyOffset - offset)
    }

    func getStatementEndOffset() -> Int64 {
        var statementEndOffset = getBodyOffset() - 1
        if statementEndOffset < 0 {
            statementEndOffset = getOffset() + getLength()
        }
        return statementEndOffset
    }

    func getBodyOffset() -> Int64 {
        return (data["key.bodyoffset"] as? Int64) ?? -1
    }

    func getBodyLength() -> Int64 {
        return (data["key.bodylength"] as? Int64) ?? -1
    }
}

// TODO: remove subclass and rename to SwiftFileBuilder
class StructureBuilder: SwiftElementBuilder {

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
        self.data = data // TODO: fix this and make data let
        guard let kind = data["key.kind"] as? String else {
            return buildSwiftElement()
        }
        switch kind {
        case "source.lang.swift.decl.protocol",
             "source.lang.swift.decl.class":
            return buildSwiftTypeElement()
        case "source.lang.swift.decl.function.method.instance",
             "source.lang.swift.decl.function.method.static",
             "source.lang.swift.decl.function.method.class",
             "source.lang.swift.decl.function.free":
            return SwiftMethodElementBuilder(data: data, fileText: fileText).build()
        case "source.lang.swift.decl.var.instance",
             "source.lang.swift.decl.var.global":
            return SwiftPropertyElementBuilder(data: data, fileText: fileText).build()
        default:
            return buildSwiftElement()
        }
    }

    private func buildSwiftFile() -> SwiftFile {
        return SwiftFile(name: getName(), text: fileText, children: buildChildren(), offset: getOffset(), length: getLength())
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

    // MARK: - InheritedType

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
            return StructureBuilder(data: newData, fileText: fileText).build()
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
