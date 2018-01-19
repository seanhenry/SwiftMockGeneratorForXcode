import SourceKittenFramework

class SKFormatRequest: FormatRequest {
    func format(filePath: String) throws -> String {
        return SourceKittenFramework.File(path: filePath)!
            .format(trimmingTrailingWhitespace: false, useTabs: false, indentWidth: 4)
    }
}
