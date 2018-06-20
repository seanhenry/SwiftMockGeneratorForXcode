class CachingResolver: ResolverDecorator {

    private var cached = [String: Element?]()

    override func resolve(_ element: Element) -> Element? {
        let id = element.text
        if let cachedElement = cached[id] {
            return cachedElement
        }
        let resolved = super.resolve(element)
        cached[id] = resolved
        return resolved
    }
}
