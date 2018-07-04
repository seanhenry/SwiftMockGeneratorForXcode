import XCTest
import SwiftStructureInterface
@testable import MockGenerator

class BufferInstructionsFactoryTests: XCTestCase {

    func test_shouldFindLinesToDeleteForEmptyClass() {
        let instructions = create("class A {\n}")
        XCTAssertEqual(instructions.deleteIndex, 1)
        XCTAssertEqual(instructions.deleteLength, 0)
    }

    func test_shouldFindLinesToDeleteForClassInBetweenTheCodeBlock() {
        let instructions = create("""
        class A {
        all
         of 
            these
            \t lines
           
        }
        """)
        XCTAssertEqual(instructions.deleteIndex, 1)
        XCTAssertEqual(instructions.deleteLength, 5)
    }

    func test_shouldReturnNilWhenFileIsNil() {
        XCTAssertNil(BufferInstructionsFactory().create(mockClass: NoFileTypeDeclaration(), lines: []))
    }

    func test_shouldReturnUntouchedLines() {
        let instructions = create("class A {\n}", lines: ["0"])
        XCTAssertEqual(instructions.linesToInsert, ["0"])
    }

    func test_shouldReturnInsertIndex() {
        let buffer = [
            "class A {\n",
            "\n",
            "}"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A {\nINSERTED\n}")
    }

    func test_shouldReturnInsertIndexForClassOnDifferentLine() {
        let buffer = [
            "func a() {\n",
            "}\n",
            "   \tclass A {\n",
            "\n",
            "}"
        ]
        assertInsertsLines(buffer, ["INSERTED\n  LINES\n"], "func a() {\n}\n   \tclass A {\nINSERTED\n  LINES\n}")
    }

    func test_shouldReplaceClassDeclarationWithBracesAreOnSameLine() {
        let buffer = [
            "class A {}"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A {\nINSERTED\n}")
    }

    func test_shouldReplaceClassDeclarationWithBracesAreOnSameLineAndAnotherDeclarationIsOnTheSameLine() {
        let buffer = [
            "class A {}class B {}"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A {\nINSERTED\n}class B {}")
    }

    func test_shouldReplaceClassDeclarationWithBracesAreOnSameLineAndStatementsAreAlsoOnTheSameLine() {
        let buffer = [
            "class A { var a: A; func c() -> String {} }"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A {\nINSERTED\n}")
    }

    func test_shouldReplaceClassDeclarationAndKeepIndentationWithBracesAreOnSameLine() {
        let buffer = [
            " \tclass A {  }"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], " \tclass A {\nINSERTED\n}")
    }

    func test_shouldOnlyPartOfClassDeclarationThatIsOnTheSameLineAsTheBrace() {
        let buffer = [
            "class A:\n",
            "B, C where C: D { }"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A:\nB, C where C: D {\nINSERTED\n}")
    }

    func test_shouldHandleWhenClassCodeBlockIsNotClosed() {
        let buffer = [
            "class A {"
        ]
        assertInsertsLines(buffer, ["INSERTED\n"], "class A {\nINSERTED\n")
    }

    private func create(_ input: String, lines: [String] = []) -> BufferInstructions {
        let file = try! ParserTestHelper.parseFile(from: input)
        let classElement = file.typeDeclarations[0]
        return BufferInstructionsFactory().create(mockClass: classElement, lines: lines)!
    }

    private func assertInsertsLines(_ input: [String], _ lines: [String], _ expected: String, line: UInt = #line) {
        var buffer = input
        let instructions = create(buffer.joined(), lines: lines)
        buffer.removeSubrange(instructions.deleteIndex..<instructions.deleteIndex+instructions.deleteLength)
        buffer.insert(contentsOf: instructions.linesToInsert, at: instructions.insertIndex)
        XCTAssertEqual(buffer.joined(), expected, line: line)
    }

    class NoFileTypeDeclaration: TypeDeclaration {

        var accessLevelModifier: AccessLevelModifier {
            fatalError()
        }
        var declarationModifiers: [DeclarationModifier] {
            return []
        }
        var typeInheritanceClause: TypeInheritanceClause {
            fatalError()
        }
        var codeBlock: CodeBlock {
            fatalError()
        }
        var attributes: Attributes {
            fatalError()
        }
        var text: String {
            return ""
        }
        var children: [Element] {
            return []
        }
        var file: File? {
            return nil
        }
        var parent: Element? {
            return nil
        }

        func accept(_ visitor: ElementVisitor) {
        }

        func isIdentical(to: Element) -> Bool {
            return false
        }
    }
}
