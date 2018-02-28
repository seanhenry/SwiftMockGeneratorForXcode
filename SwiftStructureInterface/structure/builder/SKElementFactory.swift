class SKElementFactory {

    static var structureRequest: StructureRequest = SKStructureRequest()

    func build(from string: String) -> Element? {
        if let dictionary = try? SKElementFactory.structureRequest.getStructure(contents: string) {
            return build(data: dictionary, fileText: string)
        }
        return nil
    }

    func build(fromPath path: String) -> Element? {
        guard let (dictionary, contents) = try? SKElementFactory.structureRequest.getStructure(filePath: path) else { return nil }
        return build(data: dictionary, fileText: contents)
    }

    func build(data: [String: Any], fileText: String) -> Element? {
        guard isFileData(data) else {
            return buildElement(data, fileText: fileText)
        }
        return SwiftFileBuilder(data: data, fileText: fileText).build()
    }

    private func isFileData(_ data: [String: Any]) -> Bool {
        return data["key.diagnostic_stage"] != nil
    }

    private func buildElement(_ data: [String: Any], fileText: String) -> Element? {
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
        case SwiftInheritedTypeBuilder.kind:
            return SwiftInheritedTypeBuilder(data: data, fileText: fileText).build()
        case "source.lang.swift.ref.typealias":
            return SwiftTypealiasBuilder(data: data, fileText: fileText).build()
        case "source.lang.swift.ref.generic_type_param":
            return SwiftGenericParameterTypeDeclarationBuilder(data: data, fileText: fileText).build()
        default:
            return SwiftElementBuilder(data: data, fileText: fileText).build()
        }
    }
}
