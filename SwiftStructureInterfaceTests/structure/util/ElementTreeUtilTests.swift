import XCTest
@testable import SwiftStructureInterface

class ElementTreeUtilTests: XCTestCase {

    func test_findParentType_shouldFindImmediateParent() {
        let file = SKElementFactoryTestHelper.build(from: "class A { var a = 0 }")!
        let classType = file.typeDeclarations[0]
        let propertyA = classType.variableDeclarations[0]
        let type = ElementTreeUtil().findParentType(propertyA)
        XCTAssertEqual(type?.text, classType.text)
    }

    func test_findParentType_shouldBeNil_whenNoParents() {
        let file = SKElementFactoryTestHelper.build(from: "var a = 0")!
        let propertyA = file.variableDeclarations[0]
        let type = ElementTreeUtil().findParentType(propertyA)
        XCTAssertNil(type)
    }

    func test_findParentType_shouldReturnAncestorTypeElement() {
        let file = SKElementFactoryTestHelper.build(from: "class A { func a() { func b() { func c() {} } } }")!
        let classType = file.typeDeclarations[0]
        let innerMethod = classType.functionDeclarations[0].functionDeclarations[0].functionDeclarations[0]
        let type = ElementTreeUtil().findParentType(innerMethod)
        XCTAssertEqual(type?.text, classType.text)
    }

    func test_findParentType_shouldReturnNil_whenNoTypeInHierarchy() {
        let file = SKElementFactoryTestHelper.build(from: "func a() { func b() { func c() {} } }")!
        let innerMethod = file.functionDeclarations[0].functionDeclarations[0].functionDeclarations[0]
        let type = ElementTreeUtil().findParentType(innerMethod)
        XCTAssertNil(type)
    }

    func test_findParentType_shouldNotReturnElement_whenItIsATypeItself() {
        let file = SKElementFactoryTestHelper.build(from: "class A { func b() { class C {} } }")!
        let outerClass = file.typeDeclarations[0]
        let innerClass = outerClass.functionDeclarations[0].typeDeclarations[0]
        let type = ElementTreeUtil().findParentType(innerClass)
        XCTAssertEqual(type?.text, outerClass.text)
    }
}
