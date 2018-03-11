import Foundation

class SwiftVariableDeclaration: SwiftElement, VariableDeclaration {

    let name: String
    let type: String
    let isWritable: Bool
    let attribute: String?

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, type: String, isWritable: Bool, attribute: String?) {
        self.name = name
        self.type = type
        self.isWritable = isWritable
        self.attribute = attribute
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitVariableDeclaration(self)
    }
}
