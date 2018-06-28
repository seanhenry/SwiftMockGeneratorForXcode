import XCTest
@testable import SwiftStructureInterface

class DeclarationsTests: XCTestCase {

    // MARK: - declarations

    func test_declarations_shouldFilterInitializers() {
        let declarations = getMixedElements().initializerDeclarations
        XCTAssertEqual(declarations.count, 1)
        XCTAssert(declarations[0] === testInitializerDeclaration)
    }

    func test_declarations_shouldFilterVariables() {
        let declarations = getMixedElements().variableDeclarations
        XCTAssertEqual(declarations.count, 2)
        XCTAssert(declarations[0] === testVariableDeclaration)
        XCTAssert(declarations[1] === testDeclaration)
        XCTAssert(testVariableDeclaration === testDeclaration)
    }

    func test_declarations_shouldFilterFunctions() {
        let declarations = getMixedElements().functionDeclarations
        XCTAssertEqual(declarations.count, 1)
        XCTAssert(declarations[0] === testFunctionDeclaration)
    }

    func test_declarations_shouldFilterTypeDeclarations() {
        let declarations = getMixedElements().typeDeclarations
        XCTAssertEqual(declarations.count, 2)
        XCTAssert(declarations[0] === testTypeDeclaration)
    }

    func test_declarations_shouldFilterTypealiases() {
        let declarations = getMixedElements().typealiasDeclarations
        XCTAssertEqual(declarations.count, 1)
        XCTAssert(declarations[0] === testTypealiasDeclaration)
    }

    // MARK: - Helpers

    func getMixedElements() -> Declarations {
        return TestDeclarations(allTestElements)
    }

    private class TestDeclarations: ElementImpl, Declarations {
        convenience init(_ children: [Element]) {
            self.init(children: children)
        }
    }
}
