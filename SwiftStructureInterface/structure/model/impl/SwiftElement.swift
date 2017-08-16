import SourceKittenFramework

class SwiftElement: Element {

    let children: [Element]
    private var data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], children: [Element] = []) {
        self.data = data
        self.children = children
    }

    var name: String {
        return data["key.name"] as? String ?? ""
    }
}
