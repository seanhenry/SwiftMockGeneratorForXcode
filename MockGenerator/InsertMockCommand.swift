import Foundation
import AST
import Algorithms
import SwiftyKit

public class InsertMockCommand: ASTCommandImpl, MockGenerator {

    public override var name: String { "Mock Generator" }

    public override var identifier: String { "codes.seanhenry.mockgenerator" }

    let templateName: String

    public init(templateName: String) {
        self.templateName = templateName
        super.init()
    }

    public override func execute(buffer: TextBuffer, file: File) throws {
        guard let selection = buffer.selectionRange.first?.start else {
            throw error("No selections. Place the cursor on a mock class declaration")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(
            in: file,
            line: selection.line,
            column: selection.column,
            type: Element.self
        )
        else {
            throw error("No Swift element found under the cursor")
        }
        guard let typeElement = (elementUnderCaret as? TypeDeclaration) ?? ElementTreeUtil().findParentType(
            elementUnderCaret
        )
        else {
            throw error("Place the cursor on a mock class declaration")
        }
        guard let types = typeElement.typeInheritanceClause?.inheritedTypes, types.count > 0 else {
            throw error("MockClass must inherit from a class or implement at least 1 protocol")
        }
        try generateMock(toFile: file, atElement: typeElement)
    }
}
