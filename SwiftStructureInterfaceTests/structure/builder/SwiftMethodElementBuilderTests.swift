import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftMethodElementBuilderTests: XCTestCase {

    func test_build_shouldDetectMethods() {
        let file = StructureBuilderTestHelper.build(from: getMethodsExampleString())!
        let protocolType = file.children[0] as? SwiftTypeElement
        let classType = file.children[1] as? SwiftTypeElement
        let instanceMethod = classType?.children[0] as? SwiftMethodElement
        assertChildMethodName(protocolType, at: 0, equals: "protocolMethod")
        assertChildMethodName(classType, at: 0, equals: "method")
        assertChildMethodName(instanceMethod, at: 0, equals: "nestedMethod")
        assertChildMethodName(classType, at: 1, equals: "classMethod")
        assertChildMethodName(classType, at: 2, equals: "staticMethod")
    }

    func test_build_shouldAddReturnTypeToMethods() {
        let file = StructureBuilderTestHelper.build(from: getReturnMethodsExampleString())!
        let protocolType = file.children[0] as! SwiftTypeElement
        assertChildMethodReturnType(protocolType, at: 0, equals: nil)
        assertChildMethodReturnType(protocolType, at: 1, equals: "Type0")
        assertChildMethodReturnType(protocolType, at: 2, equals: "(Type0, Type1)")
        assertChildMethodReturnType(protocolType, at: 3, equals: "(Type0) -> (Type2)")
        assertChildMethodReturnType(protocolType, at: 4, equals: "Type0<Type1>")
        assertChildMethodReturnType(protocolType, at: 5, equals: "Type0")
        assertChildMethodReturnType(protocolType, at: 6, equals: "Type0")
        let classType = file.children[1] as! SwiftTypeElement
        assertChildMethodReturnType(classType, at: 0, equals: "Type0")
        assertChildMethodReturnType(classType, at: 1, equals: "Type0")
        assertChildMethodReturnType(classType, at: 2, equals: "Type0")
        assertChildMethodReturnType(classType, at: 3, equals: "Type0")
    }

    // MARK: - Helpers

    func assertChildMethodReturnType(_ parent: Element?, at index: Int, equals expected: String?, line: UInt = #line) {
        let method = parent?.children[index] as? SwiftMethodElement
        XCTAssertEqual(method?.returnType, expected, line: line)
    }

    func assertChildMethodName(_ parent: Element?, at index: Int, equals expected: String?, line: UInt = #line) {
        let method = parent?.children[index] as? SwiftMethodElement
        XCTAssertEqual(method?.name, expected, line: line)
    }

    private func getMethodsExampleString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func protocolMethod()" + "\n" +
            "}" + "\n" +
            "" + "\n" +
            "class TestClass {" + "\n" +
            "  func method() {" + "\n" +
            "    func nestedMethod() {}" + "\n" +
            "  }" + "\n" +
            "  class func classMethod() {}" + "\n" +
            "  static func staticMethod() {}" + "\n" +
            "}" + "\n" +
            "" + "\n" +
            "func globalMethod() {}"
    }

    private func getReturnMethodsExampleString() -> String {
        return "protocol TestProtocol {" + "\n" +
            "  func method()" + "\n" +
            "  func returnMethod() -> Type0" + "\n" +
            "  func tupleMethod() -> (Type0, Type1)" + "\n" +
            "  func closureMethod() -> (Type0) -> (Type2)" + "\n" +
            "  func genericMethod() -> Type0<Type1>" + "\n" +
            "  func whitespaceMethod() ->     Type0     " + "\n" +
            "  func ticksyMethod(_ closure: () -> ()) -> Type0" + "\n" +
            "}" + "\n" +
            "class TestClass {" + "\n" +
            "  func inlineBrace() -> Type0 {" + "\n" +
            "  }" + "\n" +
            "  func inlineBraces() -> Type0 {}" + "\n" +
            "  func nextLineBrace() -> Type0" + "\n" +
            "  {}" + "\n" +
            "  func paramsOnNewlines(var: String," + "\n" +
            "  var2: Int," + "\n" +
            "  closure: (Int) -> ((Int) -> ())" + "\n" +
            "  ) -> Type0 {}" + "\n" +
            "}"
    }
}
