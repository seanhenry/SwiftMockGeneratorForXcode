import XCTest
@testable import SwiftStructureInterface

class SwiftMethodElementBuilderTests: XCTestCase {

    func test_build_shouldDetectMethods() {
        let file = SKElementFactoryTestHelper.build(from: getMethodsExampleString())!
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
        let file = SKElementFactoryTestHelper.build(from: getReturnMethodsExampleString())!
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
        XCTAssertEqual(method?.returnType?.text, expected, line: line)
    }

    func assertChildMethodName(_ parent: Element?, at index: Int, equals expected: String?, line: UInt = #line) {
        let method = parent?.children[index] as? SwiftMethodElement
        XCTAssertEqual(method?.name, expected, line: line)
    }

    private func getMethodsExampleString() -> String {
        return """
            protocol TestProtocol {
              func protocolMethod()
            }
            
            class TestClass {
              func method() {
                func nestedMethod() {}
              }
              class func classMethod() {}
              static func staticMethod() {}
            }
            
            func globalMethod() {}
            """
    }

    private func getReturnMethodsExampleString() -> String {
        return """
            protocol TestProtocol {
              func method()
              func returnMethod() -> Type0
              func tupleMethod() -> (Type0, Type1)
              func closureMethod() -> (Type0) -> (Type2)
              func genericMethod() -> Type0<Type1>
              func whitespaceMethod() ->     Type0
              func tricksyMethod(_ closure: () -> ()) -> Type0
            }
            class TestClass {
              func inlineBrace() -> Type0 {
              }
              func inlineBraces() -> Type0 {}
              func nextLineBrace() -> Type0
              {}
              func paramsOnNewlines(var1: String,
              var2: Int,
              closure: (Int) -> ((Int) -> ())
              ) -> Type0 {}
            }
            """
    }
}
