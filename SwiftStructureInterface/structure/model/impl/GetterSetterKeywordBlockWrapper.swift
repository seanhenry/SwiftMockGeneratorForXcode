class GetterSetterKeywordBlockWrapper<T: GetterSetterKeywordBlock>: ElementWrapper<T>, GetterSetterKeywordBlock {
    
    var isWritable: Bool {
        return managed.isWritable
    }
}
