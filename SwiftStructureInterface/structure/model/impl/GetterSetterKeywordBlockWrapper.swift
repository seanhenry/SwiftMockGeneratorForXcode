class GetterSetterKeywordBlockWrapper: ElementWrapper, GetterSetterKeywordBlock {

    let managedGetterSetterKeywordBlock: GetterSetterKeywordBlock

    init(_ element: GetterSetterKeywordBlock) {
        managedGetterSetterKeywordBlock = element
        super.init(element)
    }
    
    var isWritable: Bool {
        return managedGetterSetterKeywordBlock.isWritable
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGetterSetterKeywordBlock(self)
    }
}
