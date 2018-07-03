import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class CaretUtilTests: XCTestCase {

    typealias ElementAndOffset = (element: Element, offset: Int)

    var util: CaretUtil!

    override func setUp() {
        super.setUp()
        util = CaretUtil()
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - findElementUnderCaret

    func test_findElementUnderCaret_shouldReturnFirstElement() {
        assertElementNameIs("A", in: try getClassWithCaretAtFirstPositionInClass())
    }

    func test_findElementUnderCaret_shouldReturnLastElement() {
        assertElementNameIs("A", in: try getClassWithCaretAtLastPositionInClass())
    }

    func test_findElementUnderCaret_shouldReturnMethod_whenAtFirstPosition() {
        assertElementNameIs("methodA", in: try getClassWithCaretAtFirstPositionInMethod())
    }

    func test_findElementUnderCaret_shouldReturnMethod_whenAtLastBodyPosition() {
        assertElementNameIs("methodA", in: try getClassWithCaretAtLastPositionInMethod())
    }

    func test_findElementUnderCaret_shouldReturnMethod_whenCaretIsInMethodBody() {
        assertElementNameIs("methodA", in: try getClassWithCaretInMethodBody())
    }

    func test_findElementUnderCaret_shouldReturnProperty_whenAtFirstBodyPosition() {
        assertElementNameIs("varA", in: try getClassWithCaretAtFirstPositionInProperty())
    }

    func test_findElementUnderCaret_shouldReturnProperty_whenAtLastBodyPosition() {
        assertElementNameIs("varA", in: try getClassWithCaretAtLastPositionInProperty())
    }

    func test_findElementUnderCaret_shouldReturnNil_whenOutsideBounds() throws {
        let (element, offset) = try getClassWithCaretAtFileEnd()
        XCTAssertNil(util.findElementUnderCaret(in: element, cursorOffset: offset, type: Declaration.self))
        XCTAssertNil(util.findElementUnderCaret(in: element, cursorOffset: -1, type: Declaration.self))
    }

    // MARK: - Helpers

    private func assertElementNameIs(_ expected: String, in elementAndOffset: @autoclosure () throws -> ElementAndOffset, line: UInt = #line) {
        do {
            let elementOffset = try elementAndOffset()
            let found = util.findElementUnderCaret(in: elementOffset.element, cursorOffset: elementOffset.offset, type: Declaration.self) as? NamedElement
            XCTAssertEqual(found?.name, expected, line: line)
        } catch {
            XCTFail("Threw error: \(error)", line: line)
        }
    }

    private func getClassWithCaretAtFileEnd() throws -> ElementAndOffset {
        var string = getClassString()
        string.append("<caret>")
        let (contents, offset) = CaretTestHelper.findCaretOffset(string)
        return (try build(contents), Int(offset!))
    }

    private func getClassWithCaretAtFirstPositionInClass() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 1, column: 0)
    }

    private func getClassWithCaretAtLastPositionInClass() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 23, column: 0)
    }

    private func getClassWithCaretAtFirstPositionInMethod() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 16, column: 4)
    }

    private func getClassWithCaretAtLastPositionInMethod() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 18, column: 4)
    }

    private func getClassWithCaretInMethodBody() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 17, column: 4)
    }

    private func getClassWithCaretAtFirstPositionInProperty() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 3, column: 4)
    }

    private func getClassWithCaretAtLastPositionInProperty() throws -> ElementAndOffset {
        return try getClassAndOffset(line: 3, column: 19)
    }

    private func getClassAndOffset(line: Int, column: Int) throws -> ElementAndOffset {
        let string = getClassString()
        let offset = LocationConverter.convert(line: line, column: column, in: string)!
        return (try build(string), Int(offset))
    }

    private func build(_ string: String) throws -> Element {
        return try ParserTestHelper.parseFile(from: string)
    }

    private func getClassString() -> String {
        return """
class A: B {

    var varA: String
    var varB: String {
        return "varBResult"
    }
    var varC: String {
        set {

        }
        get {
            return "varCResult"
        }
    }

    func methodA() -> String {
        return "methodAResult"
    }

    func methodB(labelA nameA: String, labelB: String) {
        var methodVarA = "methodVarAResult"
    }
}
"""
    }
}
