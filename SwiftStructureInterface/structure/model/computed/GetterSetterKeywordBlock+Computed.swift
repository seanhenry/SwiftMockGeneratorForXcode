extension GetterSetterKeywordBlock {

    public var isWritable: Bool {
        return setterKeywordClause != nil
    }

    public var getterKeywordClause: GetterSetterKeywordClause {
        return children.compactMap { $0 as? GetterSetterKeywordClause }
                .first { $0.text == Keywords.get }
                ?? GetterSetterKeywordClauseImpl(children: [])
    }

    public var setterKeywordClause: GetterSetterKeywordClause? {
        return children.compactMap { $0 as? GetterSetterKeywordClause }
                .first { $0.children.contains { $0.text == Keywords.set } }
    }
}
