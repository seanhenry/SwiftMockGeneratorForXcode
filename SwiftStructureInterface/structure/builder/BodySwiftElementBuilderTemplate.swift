import SourceKittenFramework

protocol BodySwiftElementBuilderTemplate: NamedSwiftElementBuilderTemplate {
    func build(text: String, offset: Int64, length: Int64, name: String, bodyOffset: Int64, bodyLength: Int64) -> Element?
}

extension BodySwiftElementBuilderTemplate {

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        guard let bodyOffset = getBodyOffset(),
            let bodyLength = getBodyLength() else {
            return nil
        }
        return build(text: text, offset: offset, length: length, name: name, bodyOffset: bodyOffset, bodyLength: bodyLength)
    }

    func getBodyOffset() -> Int64? {
        return data["key.bodyoffset"] as? Int64
    }

    func getBodyLength() -> Int64? {
        return data["key.bodylength"] as? Int64
    }
}
