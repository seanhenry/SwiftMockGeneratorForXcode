import XCTest
import Source
import Lexer
@testable import SwiftStructureInterface

extension XCTestCase {

    func createParser<T, P: Parser<T>>(_ text: String, _ `class`: P.Type) -> P {
        let sourceFile = SourceFile(content: text)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        return P(lexer: lexer, fileContents: text)
    }

    func createDeclarationParser<T, P: DeclarationParser<T>>(_ text: String, _ kind: Token.Kind, _ `class`: P.Type) -> P {
        let sourceFile = SourceFile(content: text)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        return P(lexer: lexer, fileContents: text, declarationToken: kind)
    }
}
