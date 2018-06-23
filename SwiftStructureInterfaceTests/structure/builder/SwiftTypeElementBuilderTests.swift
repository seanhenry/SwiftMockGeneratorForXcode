import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftTypeElementBuilderTests: XCTestCase {

    func test_build_shouldBuildProtocolFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.typeDeclarations[0]
        XCTAssertEqual(element?.name, "Protocol")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].text, "Inherited")
        XCTAssertEqual(element?.variableDeclarations[0].name, "property")
        XCTAssertEqual(element?.functionDeclarations[0].name, "method")
    }

    func test_build_shouldPopulateProtocolTextOffsets() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let element = file?.children.first as? TypeDeclaration
        XCTAssertEqual(element?.offset, 0)
        XCTAssertEqual(element?.length, getProtocolLength())
        XCTAssertEqual(element?.bodyOffset, getProtocolBodyOffset())
        XCTAssertEqual(element?.bodyLength, getProtocolBodyLength())
    }

    func test_build_shouldBuildClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getClassString())
        let element = file?.typeDeclarations[0]
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 1)
        XCTAssertEqual(element?.inheritedTypes[0].text, "B")
        XCTAssertEqual(element?.variableDeclarations.count, 3)
        XCTAssertEqual(element?.variableDeclarations[0].name, "varA")
        XCTAssertEqual(element?.variableDeclarations[1].name, "varB")
        XCTAssertEqual(element?.variableDeclarations[2].name, "varC")
        XCTAssertEqual(element?.functionDeclarations.count, 2)
        XCTAssertEqual(element?.functionDeclarations[0].name, "methodA")
        XCTAssertEqual(element?.functionDeclarations[1].name, "methodB")
        XCTAssertEqual(file?.text, getClassString())
    }

    func test_build_shouldBuildNestedClassFromDictionary() {
        let file = SKElementFactoryTestHelper.build(from: getNestedClassString())
        let element = file?.typeDeclarations[0]
        XCTAssertEqual(element?.name, "A")
        XCTAssertEqual(element?.inheritedTypes.count, 0)
        XCTAssertEqual(element?.children.count, 3)
        XCTAssertEqual(element?.functionDeclarations[0].name, "methodA")
        let innerElement = element?.typeDeclarations[0]
        XCTAssertEqual(innerElement?.name, "B")
        XCTAssertEqual(innerElement?.inheritedTypes.count, 2)
        XCTAssertEqual(innerElement?.inheritedTypes[0].text, "C")
        XCTAssertEqual(innerElement?.inheritedTypes[1].text, "D")
        XCTAssertEqual(innerElement?.functionDeclarations.count, 1)
        XCTAssertEqual(innerElement?.functionDeclarations[0].name, "innerMethodA")
        XCTAssertEqual(file?.text, getNestedClassString())
    }

    func test_build_shouldSetTextOnProtocol() {
        let file = SKElementFactoryTestHelper.build(from: getProtocolString())
        let `protocol` = file?.children.first as? TypeDeclaration
        let inheritedType = `protocol`?.inheritedTypes.first
        let property = `protocol`?.variableDeclarations[0]
        let method = `protocol`?.functionDeclarations[0]
        XCTAssertEqual(file?.text, getProtocolString())
        XCTAssertEqual(`protocol`?.text, getProtocolString())
        XCTAssertEqual(inheritedType?.text, "Inherited")
        XCTAssertEqual(property?.text, "var property: String { get set }")
        XCTAssertEqual(method?.text, "func method()")
    }
    
    func test_build_shouldBuildWhereClause() {
        let file = SKElementFactoryTestHelper.build(from: "class A: B, C where C: D {}")
        let `class` = file?.typeDeclarations[0]
        XCTAssertEqual(`class`?.inheritedTypes.count, 2)
        XCTAssertEqual(`class`?.inheritedTypes[0].text, "B")
        XCTAssertEqual(`class`?.inheritedTypes[1].text, "C")
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
