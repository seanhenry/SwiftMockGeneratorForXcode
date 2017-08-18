protocol ElementVisitor {
    func visit(_ element: SwiftElement)
    func visit(_ element: SwiftTypeElement)
    func visit(_ element: SwiftFile)
}
