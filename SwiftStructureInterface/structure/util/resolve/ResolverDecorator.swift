class ResolverDecorator: Resolver {

    private let decorator: Resolver?

    init(_ decorator: Resolver?) {
        self.decorator = decorator
    }
    
    func resolve(_ element: Element) -> Element? {
        return decorator?.resolve(element)
    }
}
