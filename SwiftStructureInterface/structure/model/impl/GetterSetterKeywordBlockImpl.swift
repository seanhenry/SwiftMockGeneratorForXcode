class GetterSetterKeywordBlockImpl: ElementImpl, GetterSetterKeywordBlock {

    var getterKeywordClause: GetterSetterKeywordClause {
        return children.compactMap { $0 as? GetterSetterKeywordClause }
                .first { $0 === Keywords.get }
                ?? GetterSetterKeywordClauseImpl(children: [])
    }

    var setterKeywordClause: GetterSetterKeywordClause? {
        return children.compactMap { $0 as? GetterSetterKeywordClause }
                .first { $0.children.contains { $0 === Keywords.set } }
    }

    override init(children: [Element]) {
        super.init(children: children)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGetterSetterKeywordBlock(self)
    }
}
