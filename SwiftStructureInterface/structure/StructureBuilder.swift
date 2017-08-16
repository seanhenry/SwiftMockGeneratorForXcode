import SourceKittenFramework

class StructureBuilder {

    // TODO: Children not yet recursive
    func build(_ data: [String: SourceKitRepresentable]) -> Element? {
        guard let subStructure = getSubStructure(data: data),
              let firstElement = subStructure.first else {
            return nil
        }
        let children = getSubStructure(data: firstElement)?.map {
            return SwiftElement(data: $0)
        }
        return SwiftElement(data: firstElement, children: children ?? [])
    }

    private func getSubStructure(data: [String: SourceKitRepresentable]) -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }
}
