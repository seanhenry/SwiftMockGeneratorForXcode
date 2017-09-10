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
        case "source.lang.swift.decl.function.method.instance",
             "source.lang.swift.decl.function.method.static",
             "source.lang.swift.decl.function.method.class",
             "source.lang.swift.decl.function.free":
            return buildSwiftMethodElement()
        case "source.lang.swift.decl.var.instance",
             "source.lang.swift.decl.var.global":
            return buildSwiftPropertyElement()
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

    private func buildSwiftMethodElement() -> SwiftMethodElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        let returnType = getMethodReturnType()
        return SwiftMethodElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length, returnType: returnType)//, bodyOffset: getBodyOffset(), bodyLength: getBodyLength())
    }

    private func buildSwiftPropertyElement() -> Element {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        let isWritable = getPropertyIsWritable()
        let attributeString = getAttributeString()
        return SwiftPropertyElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length, type: getTypeName(), isWritable: isWritable, attribute: attributeString)
    }

    private func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            StructureBuilder(data: $0, text: text).build()
        } ?? []
    }

    private func getText(offset: Int64, length: Int64) -> String {
        let utf8 = text.utf8
        let lastTextIndex = Int64(utf8.count)
        if offset < 0 || length < 0 || lastTextIndex < offset + length {
            return ""
        }
        let start = utf8.index(utf8.startIndex, offsetBy: Int(offset))
        let end = utf8.index(start, offsetBy: Int(length))
        return String(utf8[start..<end])!
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

    private func getTypeName() -> String {
        return data["key.typename"] as? String ?? ""
    }

    private func getPropertyIsWritable() -> Bool {
        return data["key.setter_accessibility"] != nil
    }

    private func getAttributeString() -> String? {
        let attributes = data["key.attributes"] as? [[String: SourceKitRepresentable]]
        let attribute = attributes?.first?["key.attribute"] as? String
        var attributeString: String?
        if attribute == "source.decl.attribute.weak" {
            attributeString = "weak"
        }
        return attributeString
    }

    // MARK: - Method return type

    private func getMethodReturnType() -> String? {
        let returnStatementText = getReturnStatementText()
        let returnMarker = "->"
        let components = returnStatementText.components(separatedBy: returnMarker)
        if components.count >= 2 {
            return components[1..<components.count]
                .joined(separator: returnMarker)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }

    private func getReturnStatementText() -> String {
        var text = getDeclarationText().utf8
        var openBracketCount = 0
        var offset = text.startIndex
        repeat {
            guard let firstBracketOffset = firstBracketIndex(text: text) else { break }
            openBracketCount += isOpenBracket(bracket: text[firstBracketOffset]) ? 1 : -1
            offset = text.index(after: firstBracketOffset)
            text = text[offset..<text.endIndex]
        } while openBracketCount > 0
        return String(text[offset..<text.endIndex])!
    }

    private func isOpenBracket(bracket: UTF8.CodeUnit) -> Bool {
        return bracket == openBracketUTF8
    }

    private let closedBracketUTF8: UTF8.CodeUnit = {
        let closedBracket = ")".utf8
        return closedBracket[closedBracket.startIndex]
    }()

    private let openBracketUTF8: UTF8.CodeUnit = {
        let openBracket = "(".utf8
        return openBracket[openBracket.startIndex]
    }()

    private func firstBracketIndex(text: String.UTF8View) -> String.UTF8View.Index? {
        return text.index { $0 == openBracketUTF8 || $0 == closedBracketUTF8 }
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
            return StructureBuilder(data: newData, text: text).build()
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

    private func getDeclarationText() -> String {
        let offset = getOffset()
        let bodyOffset = getStatementEndOffset()
        return getText(offset: offset, length: bodyOffset - offset)
    }

    private func getStatementEndOffset() -> Int64 {
        var statementEndOffset = getBodyOffset() - 1
        if statementEndOffset < 0 {
            statementEndOffset = getOffset() + getLength()
        }
        return statementEndOffset
    }
}
