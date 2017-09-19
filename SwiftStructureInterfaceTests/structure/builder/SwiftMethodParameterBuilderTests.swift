import XCTest
@testable import SwiftStructureInterface

class SwiftMethodParameterBuilderTests: XCTestCase {

    func test_build_shouldBuildParameters() {
        let file = SKElementFactoryTestHelper.build(from: getMethodParametersExampleString())!
        let protocolType = file.children[0] as! SwiftTypeElement
        assertChildMethodParameterCount(protocolType, at: 0, equals: 0)
        assertChildMethodParameterCount(protocolType, at: 1, equals: 1)
        assertChildMethodParameterCount(protocolType, at: 2, equals: 2)
        assertChildMethodParameterCount(protocolType, at: 3, equals: 1)
        assertChildMethodParameterCount(protocolType, at: 4, equals: 1)
        assertChildMethodParameterText(protocolType, at: 1, atParameter: 0, equals: "param0: Int")
        assertChildMethodParameterText(protocolType, at: 2, atParameter: 0, equals: "param0: Int")
        assertChildMethodParameterText(protocolType, at: 2, atParameter: 1, equals: "param1: String")
        assertChildMethodParameterText(protocolType, at: 3, atParameter: 0, equals: "_ name0: Int")
        assertChildMethodParameterText(protocolType, at: 4, atParameter: 0, equals: "param0 : Type0")
        let classType = file.children[1] as! SwiftTypeElement
        assertChildMethodParameterCount(classType, at: 0, equals: 1)
        assertChildMethodParameterText(classType, at: 0, atParameter: 0, equals: "param0: String")
    }

    // MARK: - Helpers

    private func assertChildMethodParameterCount(_ parent: Element?, at index: Int, equals expected: Int, line: UInt = #line) {
        let method = parent?.children[index] as? SwiftMethodElement
        XCTAssertEqual(method?.parameters.count, expected, line: line)
    }

    private func assertChildMethodParameterText(_ parent: Element?, at index: Int, atParameter paramIndex: Int, equals expected: String, line: UInt = #line) {
        let method = parent?.children[index] as? SwiftMethodElement
        XCTAssertEqual(method?.parameters[paramIndex].text, expected, line: line)
    }

    private func getMethodParametersExampleString() -> String {
        return """
            protocol TestProtocol {
              func noParams()
              func oneParam(param0: Int)
              func twoParam(param0: Int, param1: String)
              func noLabelParam(_ name0: Int)
              func whitespaceParam( param0 : Type0 )
            }
            class TestClass {
              func instanceMethod(param0: String) {
                var shouldNotBecomeParameter = 0
                func methodShouldNotBecomeParameter() {}
              }
            }
            """
    }
}
