import SourceKittenFramework

class StructureBuilder {

    private let originalData: [String: SourceKitRepresentable]
    private var data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable]) {
        self.originalData = data
        self.data = data
    }

    func build() -> Element? {
        guard isFileData() else {
            return buildElement(data)
        }
        return buildFromFileData()
    }

    private func isFileData() -> Bool {
        return data["key.diagnostic_stage"] != nil
    }

    private func buildFromFileData() -> Element? {
        guard let subStructure = getSubStructure(),
              let firstElement = subStructure.first else {
            return nil
        }
        return buildElement(firstElement)
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

    private func buildSwiftElement() -> SwiftElement {
        return SwiftElement(name: getName(), children: buildChildren(), offset: getOffset(), length: getLength())
    }

    private func buildSwiftTypeElement() -> SwiftTypeElement {
        let inheritedTypes = getInheritedTypes()
        return SwiftTypeElement(name: getName(), children: buildChildren(), inheritedTypes: inheritedTypes, offset: getOffset(), length: getLength(), bodyOffset: getBodyOffset(), bodyLength: getBodyLength())
    }

    private func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            StructureBuilder(data: $0).build()
        } ?? []
    }

    private func getSubStructure() -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }

    private func getInheritedTypes() -> [Element] {
        let types = data["key.inheritedtypes"] as? [[String: SourceKitRepresentable]]
        return types?.flatMap {
            StructureBuilder(data: $0).build()
        } ?? []
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
}
