
protocol NamedSwiftElementBuilderTemplate: SwiftElementBuilderTemplate {

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element?
}

extension NamedSwiftElementBuilderTemplate {

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        guard let name = getName() else {
            return nil
        }
        return build(text: text, offset: offset, length: length, name: name)
    }

    func getName() -> String? {
        let name = data["key.name"] as? String
        return name?.components(separatedBy: "(").first
    }
}
