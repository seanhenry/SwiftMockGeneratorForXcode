extension Element {

    func first<T>(_ type: T.Type) -> T? {
        return children.first { $0 is T } as? T
    }

    func last<T>(_ type: T.Type) -> T? {
        return children.reversed().first { $0 is T } as? T
    }

    func second<T>(_ type: T.Type) -> T? {
        let types = children.compactMap { $0 as? T }
        if types.count > 1 {
            return types[1]
        }
        return nil
    }

    func contains(_ string: String) -> Bool {
        return children.filter { $0 is LeafNode }.contains { $0.text == string }
    }

    func contains(_ strings: [String]) -> Bool {
        return children.filter { $0 is LeafNode }.contains { strings.contains($0.text) }
    }
}
