import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftTypeElementBuilderTests: XCTestCase {

    func test_build_shouldBuildProtocolFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.children.first as? SwiftTypeDeclaration
        XCTAssertEqual(element?.name, "Protocol")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].text, "Inherited")
        XCTAssertEqual(element?.namedChildren.count, 2)
        XCTAssertEqual(element?.namedChild(at: 0)?.name, "property")
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "method")
    }

    func test_build_shouldPopulateProtocolTextOffsets() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.children.first as? SwiftTypeDeclaration
        XCTAssertEqual(element?.offset, 0)
        XCTAssertEqual(element?.length, getProtocolLength())
        XCTAssertEqual(element?.bodyOffset, getProtocolBodyOffset())
        XCTAssertEqual(element?.bodyLength, getProtocolBodyLength())
    }

    func test_build_shouldBuildClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getClassString())
        let element = file?.children.first as? SwiftTypeDeclaration
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].text, "B")
        XCTAssertEqual(element?.namedChildren.count, 5)
        XCTAssertEqual(element?.namedChild(at: 0)?.name, "varA")
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "varB")
        XCTAssertEqual(element?.namedChild(at: 2)?.name, "varC")
        XCTAssertEqual(element?.namedChild(at: 3)?.name, "methodA")
        XCTAssertEqual(element?.namedChild(at: 4)?.name, "methodB")
        XCTAssertEqual(file?.text, getClassString())
    }

    func test_build_shouldBuildNestedClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getNestedClassString())
        let element = file?.children.first as? SwiftTypeDeclaration
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 0)
        XCTAssertEqual(element?.children.count, 2)
        XCTAssertEqual(element?.namedChild(at: 1)?.name, "methodA")
        let innerElement = element?.children[0] as? SwiftTypeDeclaration
        XCTAssertEqual(innerElement?.name, "B")
        XCTAssertEqual(innerElement?.inheritedTypes.count, 2)
        XCTAssertEqual(innerElement?.inheritedTypes[0].text, "C")
        XCTAssertEqual(innerElement?.inheritedTypes[1].text, "D")
        XCTAssertEqual(innerElement?.namedChildren.count, 1)
        XCTAssertEqual(innerElement?.namedChild(at: 0)?.name, "innerMethodA")
        XCTAssertEqual(file?.text, getNestedClassString())
    }

    func test_build_shouldSetTextOnProtocol() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let `protocol` = file?.children.first as? SwiftTypeDeclaration
        let inheritedType = `protocol`?.inheritedTypes.first
        let property = `protocol`?.namedChildren[0]
        let method = `protocol`?.namedChildren[1]
        XCTAssertEqual(file?.text, getProtocolString())
        XCTAssertEqual(`protocol`?.text, getProtocolString())
        XCTAssertEqual(inheritedType?.text, "Inherited")
        XCTAssertEqual(property?.text, "var property: String { get set }")
        XCTAssertEqual(method?.text, "func method()")
    }

    // MARK: - Helpers

    private func getProtocolString() -> String {
        return """
            protocol Protocol: Inherited {
            
            var property: String { get set }
            
            func method()
            }
            """
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
        return """
            class A: B {
            
                var varA: String = \"varAResult\"
                var varB: String {
                    return \"varBResult\"
                }
                var varC: String {
                    set {
            
                    }
                    get {
                        return \"varCResult\"
                    }
                }
                
                func methodA() -> String {
                    return \"methodAResult\"
                }
                
                func methodB(labelA nameA: String, labelB: String) {
                    var methodVarA = \"methodVarAResult\"
                }
            }
            """
    }

    private func getNestedClassString() -> String {
        return """
            class A {
                
            class B: C, D {
            
                func innerMethodA() {}
            }
            
            func methodA() {}
            }
            """
    }
}
