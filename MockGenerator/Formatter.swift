import Formatter
import AST
import SwiftyKit

public class DefaultFormatter: Formatter {

    let useTabs: Bool
    let indentationWidth: Int

    public init(useTabs: Bool, indentationWidth: Int) {
        self.useTabs = useTabs
        self.indentationWidth = indentationWidth
    }

    public func format(_ element: Element) {
        let makeIndent: (Int) -> String = { [useTabs, indentationWidth] in
            if useTabs {
                return String(repeating: "\t", count: $0)
            } else {
                return spaceIndent(width: indentationWidth)($0)
            }
        }
        let indentOptions = IndentStrategyVisitor.Options(
          default: RegularIndentStrategy(makeIndent: makeIndent)
        )
        let newLineBetweenOptions = NewLineSpacingVisitor.Options(
          functionDeclaration: (1, 1),
          simpleVariableDeclaration: (0, 0),
          codeBlockVariableDeclaration: (1, 1),
          codeBlockSingleLineDeclaration: (0, 0),
          getSetKeywordBlockVariableDeclaration: (0, 0),
          typeDeclaration: (1, 1),
          operatorDeclaration: (1, 1),
          default: (0, 0)
        )
        let indentVisitor = FormatVisitor(indentStrategy: {
          IndentStrategyVisitor.visit($0, context: indentOptions)
        })
        let newLineInsideOptions = NewLineSpacingVisitor.Options(
          typeDeclaration: (1, 0)
        )
        let visitors: [ElementVisitor] = [
          NewLineBetweenDeclaration(spacing: { NewLineSpacingVisitor.visit($0, context: newLineBetweenOptions) }),
          NewLineInsideDeclaration(spacing: { NewLineSpacingVisitor.visit($0, context: newLineInsideOptions) }),
          NewLineAroundImports(spacing: (1, 1)),
          EmptyBraces(),

          indentVisitor,
        ]
        visitors.forEach {
          element.accept(CompoundRecursiveVisitor($0))
        }
    }
}
