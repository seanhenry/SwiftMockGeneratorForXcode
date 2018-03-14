public protocol FormatRequest {
    func format(filePath: String) throws -> String
}
