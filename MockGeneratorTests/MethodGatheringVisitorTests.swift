import XCTest
import SourceKittenFramework
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!

    override func setUp() {
        super.setUp()
        visitor = MethodGatheringVisitor()
        ResolveUtil.sameFileCursorInfoRequest = SKCursorInfoRequest(files: [])
        ResolveUtil.cursorInfoRequest = SKCursorInfoRequest(files: [])
    }

    override func tearDown() {
        visitor = nil
        super.tearDown()
    }

    // MARK: - visit
    
    func test_shouldTransformTypeIdentifier() {
        assertTypeIs("Type", UseCasesTypeIdentifier.self, "Type")
    }

    func test_shouldTransformGenericType() {
        assertTypeIs("Type<A>", UseCasesGenericType.self, "Type<A>")
    }

    func test_shouldTransformGenericTypeWithMultipleArguments() {
        assertTypeIs("Type<A, B>", UseCasesGenericType.self, "Type<A, B>")
    }

    func test_shouldTransformGenericTypeWithNestedTypes() {
        assertTypeIs("Type<A.B>", UseCasesGenericType.self, "Type<A.B>")
    }

    func test_shouldTransformNestedTypes() {
        assertTypeIs("A.B.C", UseCasesTypeIdentifier.self, "A.B.C")
        let type = transform("A.B", UseCasesTypeIdentifier.self)
        XCTAssertEqual(type.identifiers[0] as! String, "A")
        XCTAssertEqual(type.identifiers[1] as! String, "B")
    }

    private func assertTypeIs<T: UseCasesType>(_ input: String, _ t: T.Type, _ text: String, line: UInt = #line) {
        let type = FileParser(fileContents: input).parseType()
        let result = MethodGatheringVisitor.transformType(type)
        XCTAssert(result is T, line: line)
        XCTAssertEqual(result.text, text, line: line)
    }

    private func transform<T: UseCasesType>(_ input: String, _ t: T.Type) -> T {
        let type = FileParser(fileContents: input).parseType()
        return MethodGatheringVisitor.transformType(type) as! T
    }

    // MARK: - Helpers

    private func getMethodProtocol() -> Element {
        let file = FileParser(fileContents: getMethodProtocolString()).parse()
        return file.children[0]
    }

    private func getMethodProtocolString() -> String {
        return """
        protocol TestProtocol {
            func method()
            func method2(label name: Type) -> String
            func method3(label name: Type, param: OtherType) -> String
        }
        """
    }

    private func getPropertyProtocol() -> Element {
        let file = FileParser(fileContents: getPropertyProtocolString()).parse()
        return file.children[0]
    }

    private func getPropertyProtocolString() -> String {
        return """
            protocol TestProtocol {
              var prop1: Int { get set }
              var prop2: String! { get }
              weak var prop3: NSObject? { set get }
            }
        """
    }

    private func getParametersString(_ method: UseCasesMethod) -> String {
        let parameters = method.parametersList
        return parameters.map { $0.text }.joined(separator: ", ")
    }
}
