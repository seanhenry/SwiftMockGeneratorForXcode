import XCTest
@testable import SwiftStructureInterface

class SwiftGenericParameterTypeDeclarationBuilderTests: XCTestCase {

    // MARK: - build

    func test_build_shouldBuildWithElementParameters() {
        let parameter = SKElementFactory().build(data: getParameterData(), fileText: getParameterString()) as! GenericParameterTypeDeclaration
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 1)
        XCTAssertEqual(parameter.text, "T")
        XCTAssertEqual(parameter.children.count, 0)
    }

    // MARK: - Helpers

    func getParameterData() -> [String: Any] {
        return [
            "key.filepath": "/Users/sean/Library/Developer/Xcode/DerivedData/MockGenerator-gqxiwuxwmjkgqkhhfoywqkjghksb/Build/Products/Debug/MockGeneratorTests.xctest/Contents/Resources/TestProject/GenericMethod.swift",
            "key.typename": "T.Type",
            "key.length": 1,
            "key.name": "T",
            "key.kind": "source.lang.swift.ref.generic_type_param",
            "key.offset": 0,
        ]
    }

    func getParameterString() -> String {
        return "T"
    }
}
