class SwiftMethodElementBuilder: NamedSwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        let parameters = buildParameters()
        let returnType = buildReturnType(methodOffset: offset, parameters: parameters)
        var children = parameters as [Element]
        returnType.map { children.append($0) }
        return SwiftFunctionDeclaration(name: name, text: text, children: children + buildChildren(), offset: offset, length: length, returnType: returnType, parameters: parameters)
    }

    private func buildParameters() -> [Parameter] {
        return (getSubStructure() ?? [])
            .filter { $0["key.kind"] as? String == "source.lang.swift.decl.var.parameter" }
            .map { SwiftMethodParameterBuilder(data: $0, fileText: fileText).build() }
            .compactMap { $0 as? Parameter }
    }

    private func buildReturnType(methodOffset: Int64, parameters: [Parameter]) -> Element? {
        var returnType: Element?
        if let declarationText = getDeclarationText() {
            returnType = getMethodReturnType(methodOffset: methodOffset, parameters: parameters, methodText: declarationText)
        }
        return returnType
    }

    private func getMethodReturnType(methodOffset: Int64, parameters: [Parameter], methodText: String) -> Element? {
        let offset: Int64 = parameters.first?.offset ?? methodOffset
        let length: Int64 = parameters.last.map { $0.offset + $0.length - offset } ?? 0
        return SwiftMethodReturnTypeBuilder(methodDeclarationText: getDeclarationText()!,
            endOfParametersOffset: offset + length,
            methodDeclarationOffset: methodOffset).build()
    }
}
