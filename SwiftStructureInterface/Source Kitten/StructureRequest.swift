protocol StructureRequest {
    func getStructure(contents: String) throws -> [String: Any]
    func getStructure(filePath: String) throws -> ([String: Any], String)
}
