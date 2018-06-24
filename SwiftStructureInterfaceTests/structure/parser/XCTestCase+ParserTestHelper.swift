import XCTest
import Source
import Lexer
@testable import SwiftStructureInterface

extension XCTestCase {

    func assertElementText(_ element: Element?, _ text: String, offset: Int64 = 0, file: StaticString = #file, line: UInt = #line) {
        guard let e = element else {
            XCTAssertNotNil(element, file: file, line: line)
            return
        }
        XCTAssertEqual(e.text, text, file: file, line: line)
    }

    func createParser<T, P: Parser<T>>(_ text: String, _ `class`: P.Type) -> P {
        let sourceFile = SourceFile(content: text)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        return P(lexer: lexer, fileContents: text, locationConverter: CachedLocationConverter(text))
    }

    func createDeclarationParser<T, P: DeclarationParser<T>>(_ text: String, _ kind: Token.Kind, _ `class`: P.Type) -> P {
        let sourceFile = SourceFile(content: text)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        return P(lexer: lexer, fileContents: text, declarationToken: kind, locationConverter: CachedLocationConverter(text))
    }
}
