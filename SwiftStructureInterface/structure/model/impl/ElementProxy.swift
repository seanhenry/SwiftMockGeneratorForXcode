class ElementProxy: Element {

    let managed: Element
    private static let wrapVisitor = ManagedElementVisitor()

    var text: String {
        return managed.text
    }

    // TODO: Now all elements are computed, there is no longer any danger of leaking unwrapped elements because all computed elements come from here. (Not including file and parent)
    // TODO: write test to ensure no Proxys can be added. Would cause indefinite retain cycle
    // TODO: write test when settings an element to ensure they are unwrapped before being set (this would cause indefinite retain cycle)
    var children: [Element] {
        set { managed.children = children }
        get { return managed.children.map(proxy) }
    }

    var file: File? {
        return managed.file.flatMap(proxy)
    }

    var parent: Element? {
        return managed.parent.flatMap(proxy)
    }

    init(_ element: Element) {
        self.managed = element
        retainManagedFile(managed: element)
    }

    private func retainManagedFile(managed: Element) {
        let file = managed.file as? FileImpl
        file?.retainCount += 1
    }

    deinit {
        releaseManagedFile()
    }

    private func releaseManagedFile() {
        let file = managed.file as? FileImpl
        file?.retainCount -= 1
        if file?.retainCount == 0 {
            let visitor = BreakRetainCycleVisitor()
            file?.accept(visitor)
        }
    }

    private class BreakRetainCycleVisitor: RecursiveElementVisitor {

        override func visitElement(_ element: Element) {
            (element as? ElementImpl)?.file = nil
            super.visitElement(element)
        }
    }

    func accept(_ visitor: ElementVisitor) {
        managed.accept(visitor)
    }

    func proxy<T>(_ element: Any) -> T {
        guard let e = element as? Element else {
            return element as! T
        }
        e.accept(ElementProxy.wrapVisitor)
        defer { ElementProxy.wrapVisitor.proxy = nil }
        return ElementProxy.wrapVisitor.proxy as! T
    }
}
