import SourceKittenFramework

class SKElementFactory {

    func build(from string: String) -> Element {
        let dictionary = Structure(file: SourceKittenFramework.File(contents: string)).dictionary
        return build(data: dictionary, fileText: string)
    }

    func build(fromPath path: String) -> Element? {
        guard let file = SourceKittenFramework.File(path: path) else { return nil }
        let dictionary = Structure(file: file).dictionary
        return SKElementFactory().build(data: dictionary, fileText: file.contents)
    }

    func build(data: [String: SourceKitRepresentable], fileText: String) -> Element {
        guard isFileData(data) else {
            return buildElement(data, fileText: fileText)
        }
        return SwiftFileBuilder(data: data, fileText: fileText).build()
    }

    private func isFileData(_ data: [String: SourceKitRepresentable]) -> Bool {
        return data["key.diagnostic_stage"] != nil
    }

    private func buildElement(_ data: [String: SourceKitRepresentable], fileText: String) -> Element {
        guard let kind = data["key.kind"] as? String else {
            return SwiftElementBuilder(data: data, fileText: fileText).build()
        }
        switch kind {
        case "source.lang.swift.decl.protocol",
             "source.lang.swift.decl.class":
            return SwiftTypeElementBuilder(data: data, fileText: fileText).build()
        case "source.lang.swift.decl.function.method.instance",
             "source.lang.swift.decl.function.method.static",
             "source.lang.swift.decl.function.method.class",
             "source.lang.swift.decl.function.free":
            return SwiftMethodElementBuilder(data: data, fileText: fileText).build()
        case "source.lang.swift.decl.var.instance",
             "source.lang.swift.decl.var.global":
            return SwiftPropertyElementBuilder(data: data, fileText: fileText).build()
        default:
            return SwiftElementBuilder(data: data, fileText: fileText).build()
        }
    }
}
