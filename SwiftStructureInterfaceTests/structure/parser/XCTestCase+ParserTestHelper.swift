import XCTest
import Source
import Lexer
@testable import SwiftStructureInterface

extension XCTestCase {

    func createParser<T, P: Parser<T>>(_ text: String, _ `class`: P.Type) -> P {
        let sourceFile = SourceFile(content: text)
        let lexer = Lexer(source: sourceFile)
        return P(lexer: lexer, sourceFile: sourceFile)
    }
}
