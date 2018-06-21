import XCTest
@testable import SwiftStructureInterface

class GenericParameterResolverTests: XCTestCase {

    var spy: ResolverSpy!

    override func setUp() {
        super.setUp()
        spy = ResolverSpy()
    }

    func test_shouldReturnGenericParameterWhenTypeResolvesToOne() {
        let resolved = resolveParameter(in: "func a<T>(a: T)")
        XCTAssert(resolved is GenericParameter)
        XCTAssertEqual(resolved?.text, "T")
    }

    func test_shouldReturnNilWhenNoParameterClause() {
        XCTAssertNil(resolveParameter(in: "func a(a: T)"))
    }

    func test_shouldReturnNilWhenNoMatchingGenericParameter() {
        XCTAssertNil(resolveParameter(in: "func a<U>(a: T)"))
    }

    func test_shouldReturnGenericParameterWhenManyParameters() {
        XCTAssertEqual(resolveParameter(in: "func a<U: Y, V, T: Z>(a: T)")?.text, "T: Z")
    }

    func test_shouldReturnDecoratorResultWhenCannotResolve() {
        spy.stubbedResolveResult = testElement
        XCTAssert(resolveParameter(in: "func a(a: T)") === testElement)
    }

    @discardableResult
    private func resolveParameter(in contents: String) -> Element? {
        let filePath = writeFile(contents)
        let parsedFile = ElementParser.parseFile(at: filePath)!
        let resolver = GenericParameterResolver(spy)
        return resolver.resolve(parsedFile.functionDeclarations[0].parameters[0].typeAnnotation.type)
    }

    private func writeFile(_ contents: String) -> String {
        let writer = TempFileWriterUtil()
        writer.write(contents)
        return writer.tempFile
    }
}
