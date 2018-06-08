import Foundation

class SwiftVariableDeclaration: ElementImpl, VariableDeclaration {

    static let errorVariableDeclaration = SwiftVariableDeclaration(name: "", text: "", children: [], offset: -1, length: -1, type: SwiftType.errorType, isWritable: false)
    let name: String
    let type: Type
    let isWritable: Bool

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, type: Type, isWritable: Bool) {
        self.name = name
        self.type = type
        self.isWritable = isWritable
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitVariableDeclaration(self)
    }
}
