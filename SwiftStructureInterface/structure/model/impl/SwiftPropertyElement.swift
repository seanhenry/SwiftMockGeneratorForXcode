import Foundation

class SwiftPropertyElement: SwiftElement {

    let type: String
    let isWritable: Bool

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, type: String, isWritable: Bool) {
        self.type = type
        self.isWritable = isWritable
        super.init(name: name, text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
