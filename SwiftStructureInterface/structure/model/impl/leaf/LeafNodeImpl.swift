class LeafNodeImpl: ElementImpl, LeafNode {

    private var storedText: String

    override var text: String {
        set {
            storedText = newValue
        } get {
            return storedText
        }
    }

    init(text: String) {
        storedText = text
        super.init(children: [])
    }
}
