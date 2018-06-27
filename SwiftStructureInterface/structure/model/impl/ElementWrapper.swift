class ElementWrapper: Element {

    let managed: Element
    private static let wrapVisitor = ManagedElementVisitor()

    var text: String {
        return managed.text
    }

    var children: [Element] {
        return managed.children.map(wrap)
    }

    var file: File? {
        return managed.file.flatMap(wrap)
    }

    var parent: Element? {
        return managed.parent.flatMap(wrap)
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

    func wrap<T>(_ element: Any) -> T {
        guard let e = element as? Element else {
            return element as! T
        }
        e.accept(ElementWrapper.wrapVisitor)
        defer { ElementWrapper.wrapVisitor.wrapped = nil }
        return ElementWrapper.wrapVisitor.wrapped as! T
    }
}
