import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTests: XCTestCase {

    // MARK: - build

    func test_build_shouldBuildProtocolFromDictionary() {
        let element = StructureBuilder(data: getProtocol()).build() as? SwiftTypeElement
        XCTAssertEqual(element?.name, "Protocol")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].name, "Inherited")
        XCTAssertEqual(element?.children.count, 2)
        XCTAssertEqual(element?.children[0].name, "property")
        XCTAssertEqual(element?.children[1].name, "method")
    }

    func test_build_shouldPopulateOffsets() {
        let element = StructureBuilder(data: getProtocol()).build() as? SwiftTypeElement
        XCTAssertEqual(element?.offset, 0)
        XCTAssertEqual(element?.length, getProtocolLength())
        XCTAssertEqual(element?.bodyOffset, getProtocolBodyOffset())
        XCTAssertEqual(element?.bodyLength, getProtocolBodyLength())
    }

    func test_build_shouldBuildClassFromDictionary() {
        let element = StructureBuilder(data: getClass()).build() as? SwiftTypeElement
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].name, "B")
        XCTAssertEqual(element?.children.count, 5)
        XCTAssertEqual(element?.children[0].name, "varA")
        XCTAssertEqual(element?.children[1].name, "varB")
        XCTAssertEqual(element?.children[2].name, "varC")
        XCTAssertEqual(element?.children[3].name, "methodA")
        XCTAssertEqual(element?.children[4].name, "methodB")
    }

    func test_build_shouldBuildNestedClassFromDictionary() {
        let element = StructureBuilder(data: getNestedClass()).build() as? SwiftTypeElement
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 0)
        XCTAssertEqual(element?.children.count, 2)
        XCTAssertEqual(element?.children[1].name, "methodA")
        let innerElement = element?.children[0] as? SwiftTypeElement
        XCTAssertEqual(innerElement?.name, "B")
        XCTAssertEqual(innerElement?.inheritedTypes.count, 2)
        XCTAssertEqual(innerElement?.inheritedTypes[0].name, "C")
        XCTAssertEqual(innerElement?.inheritedTypes[1].name, "D")
        XCTAssertEqual(innerElement?.children.count, 1)
        XCTAssertEqual(innerElement?.children[0].name, "innerMethodA")
    }

    // MARK: - Helpers

    private func getProtocol() -> [String: SourceKitRepresentable] {
        let protocolDeclaration = getProtocolString()
        return Structure(file: File(contents: protocolDeclaration))
            .dictionary
    }

    private func getProtocolString() -> String {
        return "protocol Protocol: Inherited {" + "\n" +
            "    " + "\n" +
            "    var property: String { get set }" + "\n" +
            "    " + "\n" +
            "    func method()" + "\n" +
            "}"
    }

    private func getProtocolLength() -> Int64 {
        return Int64(getProtocolString().characters.count)
    }

    private func getProtocolBodyOffset() -> Int64 {
        return 30
    }

    private func getProtocolBodyLength() -> Int64 {
        let endCurlyBrace: Int64 = 1
        return getProtocolLength() - getProtocolBodyOffset() - endCurlyBrace
    }

    private func getClass() -> [String: SourceKitRepresentable] {
        let classDeclaration = getClassString()
        return Structure(file: File(contents: classDeclaration))
            .dictionary
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

    private func getNestedClass() -> [String: SourceKitRepresentable] {
        let classDeclaration = getNestedClassString()
        return Structure(file: File(contents: classDeclaration))
            .dictionary
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
