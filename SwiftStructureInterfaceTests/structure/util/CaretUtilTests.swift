//import XCTest
//import SourceKittenFramework
//@testable import SwiftStructureInterface
//
//class CaretUtilTests: XCTestCase {
//
//    typealias ElementAndOffset = (element: Element, offset: Int64)
//
//    var util: CaretUtil!
//
//    override func setUp() {
//        super.setUp()
//        util = CaretUtil()
//    }
//
//    override func tearDown() {
//        util = nil
//        super.tearDown()
//    }
//
//    // MARK: - findElementUnderCaret
//
//    func test_findElementUnderCaret_shouldReturnFirstElement() {
//        assertElementNameIs("A", in: getClassWithCaretAtFirstPositionInClass())
//    }
//
//    func test_findElementUnderCaret_shouldReturnLastElement() {
//        assertElementNameIs("A", in: getClassWithCaretAtLastPositionInClass())
//    }
//
//    func test_findElementUnderCaret_shouldReturnMethod_whenAtFirstPosition() {
//        assertElementNameIs("methodA", in: getClassWithCaretAtFirstPositionInMethod())
//    }
//
//    func test_findElementUnderCaret_shouldReturnMethod_whenAtLastBodyPosition() {
//        assertElementNameIs("methodA", in: getClassWithCaretAtLastPositionInMethod())
//    }
//
//    func test_findElementUnderCaret_shouldReturnMethod_whenCaretIsInMethodBody() {
//        assertElementNameIs("methodA", in: getClassWithCaretInMethodBody())
//    }
//
//    func test_findElementUnderCaret_shouldReturnProperty_whenAtFirstBodyPosition() {
//        assertElementNameIs("varA", in: getClassWithCaretAtFirstPositionInProperty())
//    }
//
//    func test_findElementUnderCaret_shouldReturnProperty_whenAtLastBodyPosition() {
//        assertElementNameIs("varA", in: getClassWithCaretAtLastPositionInProperty())
//    }
//
//    func test_findElementUnderCaret_shouldReturnNil_whenOutsideBounds() {
//        let (element, offset) = getClassWithCaretAtFileEnd()
//        XCTAssertNil(util.findElementUnderCaret(in: element, cursorOffset: offset))
//        XCTAssertNil(util.findElementUnderCaret(in: element, cursorOffset: -1))
//    }
//
//    // MARK: - Helpers
//
//    private func assertElementNameIs(_ expected: String, in elementAndOffset: ElementAndOffset, line: UInt = #line) {
//        let found = util.findElementUnderCaret(in: elementAndOffset.element, cursorOffset: elementAndOffset.offset) as? NamedElement
//        XCTAssertEqual(found?.name, expected, line: line)
//    }
//
//    private func getClassWithCaretAtFileEnd() -> ElementAndOffset {
//        var string = getClassString()
//        string.append("<caret>")
//        let (contents, offset) = CaretTestHelper.findCaretOffset(string)
//        return (build(contents), offset!)
//    }
//
//    private func getClassWithCaretAtFirstPositionInClass() -> ElementAndOffset {
//        return getClassAndOffset(line: 1, column: 0)
//    }
//
//    private func getClassWithCaretAtLastPositionInClass() -> ElementAndOffset {
//        return getClassAndOffset(line: 23, column: 0)
//    }
//
//    private func getClassWithCaretAtFirstPositionInMethod() -> ElementAndOffset {
//        return getClassAndOffset(line: 16, column: 4)
//    }
//
//    private func getClassWithCaretAtLastPositionInMethod() -> ElementAndOffset {
//        return getClassAndOffset(line: 18, column: 4)
//    }
//
//    private func getClassWithCaretInMethodBody() -> ElementAndOffset {
//        return getClassAndOffset(line: 17, column: 4)
//    }
//
//    private func getClassWithCaretAtFirstPositionInProperty() -> ElementAndOffset {
//        return getClassAndOffset(line: 3, column: 4)
//    }
//
//    private func getClassWithCaretAtLastPositionInProperty() -> ElementAndOffset {
//        return getClassAndOffset(line: 3, column: 34)
//    }
//
//    private func getClassAndOffset(line: Int, column: Int) -> ElementAndOffset {
//        let string = getClassString()
//        let offset = LocationConverter.convert(line: line, column: column, in: string)!
//        return (build(string), offset)
//    }
//
//    private func build(_ string: String) -> Element {
//        return SKElementFactoryTestHelper.build(from: string)!
//    }
//
//    private func getClassString() -> String {
//        return """
//class A: B {
//
//    var varA: String = \"varAResult\"
//    var varB: String {
//        return \"varBResult\"
//    }
//    var varC: String {
//        set {
//
//        }
//        get {
//            return \"varCResult\"
//        }
//    }
//
//    func methodA() -> String {
//        return \"methodAResult\"
//    }
//
//    func methodB(labelA nameA: String, labelB: String) {
//        var methodVarA = \"methodVarAResult\"
//    }
//}
//"""
//    }
//}
