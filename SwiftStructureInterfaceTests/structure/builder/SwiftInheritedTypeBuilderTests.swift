import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftInheritedTypeBuilderTests: XCTestCase {

    // Inherited declaration offsets are missing in SourceKit
    func test_build_shouldCalculateOffsetsForInheritedTypes() {
        let file = SKElementFactoryTestHelper.build(from: getInheritedTypesExampleString())
        let `protocol` = file?.children.first as? TypeDeclarationImpl
        let simpleType = `protocol`?.inheritedTypes[0]
        XCTAssertEqual(simpleType?.offset, 19)
        XCTAssertEqual(simpleType?.length, 19)
        XCTAssertEqual(simpleType?.text, "SimpleInheritedType")
        let genericType = `protocol`?.inheritedTypes[1]
        XCTAssertEqual(genericType?.offset, 40)
        XCTAssertEqual(genericType?.length, 15)
        XCTAssertEqual(genericType?.text, "Generic<String>")
        let snakeCaseType = `protocol`?.inheritedTypes[2]
        XCTAssertEqual(snakeCaseType?.offset, 60)
        XCTAssertEqual(snakeCaseType?.length, 10)
        XCTAssertEqual(snakeCaseType?.text, "snake_case")
    }

    func test_build_shouldCalculateOffsetsForInheritedTypes_whenUTF16CharactersArePresent() {
        // "💐".utf8.count = 4
        // SourceKit doesn't seem to support inherited types with emojis in their name.
        print(UnicodeScalar(0x2D30)!)
        let string = "protocol 💐Protocol: Type1 { }"
        let file = SKElementFactoryTestHelper.build(from: string)
        let `protocol` = file?.children.first as? TypeDeclarationImpl
        let type1 = `protocol`?.inheritedTypes[0]
        XCTAssertEqual(type1?.offset, 23)
        XCTAssertEqual(type1?.length, 5)
        XCTAssertEqual(type1?.text, "Type1")
    }

    func test_build_shouldBuildWithNoInheritedTypes() {
        let file = SKElementFactoryTestHelper.build(from: getNoInheritedTypesExampleString())
        let element = file?.children[0] as! TypeDeclarationImpl
        XCTAssert(element.inheritedTypes.isEmpty)
    }

    func test_build_shouldNotConfusePartiallyMatchingStringsInClassNameAndInheritedTypes() {
        let file = SKElementFactoryTestHelper.build(from: getRealisticNameExampleString())
        let element = file?.children[0] as! TypeDeclarationImpl
        let inheritedType = element.inheritedTypes[0]
        XCTAssertEqual(element.name, "MockProtocol")
        XCTAssertEqual(inheritedType.text, "Protocol")
        XCTAssertEqual(inheritedType.offset, 20)
        XCTAssertEqual(inheritedType.length, 8)
    }

    func test_build_shouldFindInheritedTypesOnNewlines() {
        let file = SKElementFactoryTestHelper.build(from: getNewlineTypesExampleString())
        let element = file?.children[0] as! TypeDeclarationImpl
        let inheritedType = element.inheritedTypes[0]
        let inheritedType2 = element.inheritedTypes[1]
        XCTAssertEqual(element.name, "AClass")
        XCTAssertEqual(inheritedType.text, "ProtocolA")
        XCTAssertEqual(inheritedType.offset, 14)
        XCTAssertEqual(inheritedType.length, 9)
        XCTAssertEqual(inheritedType2.text, "Prot")
        XCTAssertEqual(inheritedType2.offset, 26)
        XCTAssertEqual(inheritedType2.length, 4)
    }

    func test_build_shouldFindMultipleTypesInBaseOfFile() {
        let file = SKElementFactoryTestHelper.build(from: getMultipleTypeExampleString())
        let firstType = file?.children[0] as! TypeDeclarationImpl
        XCTAssertEqual(firstType.name, "ProtocolA")
        let secondType = file?.children[1] as! TypeDeclarationImpl
        let inheritedType = secondType.inheritedTypes[0]
        XCTAssertEqual(secondType.name, "ClassA")
        XCTAssertEqual(inheritedType.text, "ProtocolA")
        XCTAssertEqual(inheritedType.offset, 37)
        XCTAssertEqual(inheritedType.length, 9)
    }

    // MARK: - Helpers

    private func getInheritedTypesExampleString() -> String {
        return """
            protocol Protocol: SimpleInheritedType, Generic<String>  ,  snake_case {

            }
            """
    }

    private func getNoInheritedTypesExampleString() -> String {
        return """
            protocol Protocol {

            }
            """
    }

    private func getRealisticNameExampleString() -> String {
        return """
            class MockProtocol: Protocol {

            }
            """
    }

    private func getNewlineTypesExampleString() -> String {
        return """
            class AClass: ProtocolA ,
            Prot
            {
            }
            """
    }

    private func getMultipleTypeExampleString() -> String {
        return """
            protocol ProtocolA {}

            class ClassA: ProtocolA {}
            """
    }
}
