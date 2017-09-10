import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftTypeElementBuilderTests: XCTestCase {

    func test_build_shouldBuildProtocolFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.children.first as? SwiftTypeElement
        XCTAssertEqual(element?.name, "Protocol")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].name, "Inherited")
        XCTAssertEqual(element?.children.count, 2)
        XCTAssertEqual(element?.namedChild(at: 0)?.name, "property")
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "method")
        XCTAssert(element?.file === file)
        XCTAssert(element?.children[0].file === file)
        XCTAssert(element?.children[1].file === file)
    }

    func test_build_shouldPopulateProtocolTextOffsets() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.children.first as? SwiftTypeElement
        XCTAssertEqual(element?.offset, 0)
        XCTAssertEqual(element?.length, getProtocolLength())
        XCTAssertEqual(element?.bodyOffset, getProtocolBodyOffset())
        XCTAssertEqual(element?.bodyLength, getProtocolBodyLength())
    }

    func test_build_shouldBuildClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getClassString())
        let element = file?.children.first as? SwiftTypeElement
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].name, "B")
        XCTAssertEqual(element?.children.count, 5)
        XCTAssertEqual(element?.namedChild(at: 0)?.name, "varA")
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "varB")
        XCTAssertEqual(element?.namedChild(at: 2)?.name, "varC")
        XCTAssertEqual(element?.namedChild(at: 3)?.name, "methodA")
        XCTAssertEqual(element?.namedChild(at: 4)?.name, "methodB")
        XCTAssertEqual(file?.text, getClassString())
    }

    func test_build_shouldBuildNestedClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getNestedClassString())
        let element = file?.children.first as? SwiftTypeElement
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 0)
        XCTAssertEqual(element?.children.count, 2)
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "methodA")
        let innerElement = element?.children[0] as? SwiftTypeElement
        XCTAssertEqual(innerElement?.name, "B")
        XCTAssertEqual(innerElement?.inheritedTypes.count, 2)
        XCTAssertEqual(innerElement?.inheritedTypes[0].name, "C")
        XCTAssertEqual(innerElement?.inheritedTypes[1].name, "D")
        XCTAssertEqual(innerElement?.children.count, 1)
        XCTAssertEqual(innerElement?.namedChild(at: 0)?.name, "innerMethodA")
        XCTAssertEqual(file?.text, getNestedClassString())
    }

    func test_build_shouldSetTextOnProtocol() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let `protocol` = file?.children.first as? SwiftTypeElement
        let inheritedType = `protocol`?.inheritedTypes.first
        let property = `protocol`?.children[0]
        let method = `protocol`?.children[1]
        XCTAssertEqual(file?.text, getProtocolString())
        XCTAssertEqual(`protocol`?.text, getProtocolString())
        XCTAssertEqual(inheritedType?.text, "Inherited")
        XCTAssertEqual(property?.text, "var property: String { get set }")
        XCTAssertEqual(method?.text, "func method()")
    }

    // MARK: - Helpers

    private func getProtocolString() -> String {
        return "protocol Protocol: Inherited {" + "\n" +
            "    " + "\n" +
            "    var property: String { get set }" + "\n" +
            "    " + "\n" +
            "    func method()" + "\n" +
            "}"
    }

    private func getProtocolLength() -> Int64 {
        return Int64(getProtocolString().utf8.count)
    }

    private func getProtocolBodyOffset() -> Int64 {
        return 30
    }

    private func getProtocolBodyLength() -> Int64 {
        let endCurlyBrace: Int64 = 1
        return getProtocolLength() - getProtocolBodyOffset() - endCurlyBrace
    }

    private func getClassString() -> String {
        return "class A: B {" + "\n" +
            "    " + "\n" +
            "    var varA: String = \"varAResult\"" + "\n" +
            "    var varB: String {" + "\n" +
            "        return \"varBResult\"" + "\n" +
            "    }" + "\n" +
            "    var varC: String {" + "\n" +
            "        set {" + "\n" +
            "            " + "\n" +
            "        }" + "\n" +
            "        get {" + "\n" +
            "            return \"varCResult\"" + "\n" +
            "        }" + "\n" +
            "    }" + "\n" +
            "    " + "\n" +
            "    func methodA() -> String {" + "\n" +
            "        return \"methodAResult\"" + "\n" +
            "    }" + "\n" +
            "    " + "\n" +
            "    func methodB(labelA nameA: String, labelB: String) {" + "\n" +
            "        var methodVarA = \"methodVarAResult\"" + "\n" +
            "    }" + "\n" +
            "}"
    }

    private func getNestedClassString() -> String {
        return "class A {" + "\n" +
            "    " + "\n" +
            "    class B: C, D {" + "\n" +
            "" + "\n" +
            "        func innerMethodA() {}" + "\n" +
            "    }" + "\n" +
            "" + "\n" +
            "    func methodA() {}" + "\n" +
            "}"
    }
}
