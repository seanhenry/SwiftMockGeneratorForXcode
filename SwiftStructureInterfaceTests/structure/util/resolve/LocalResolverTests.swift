import XCTest
@testable import SwiftStructureInterface

class LocalResolverTests: XCTestCase {

    var spy: ResolverSpy!

    override func setUp() {
        super.setUp()
        spy = ResolverSpy()
    }

    func test_shouldReturnDecoratorResultWhenCannotResolve() {
        spy.stubbedResolveResult = testElement
        XCTAssert(resolveParameter(in: "func a(a: T)") === testElement)
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

    func test_shouldResolveProtocolTypealias() {
        let resolved = resolveProtocolParameter(in: "protocol A { typealias T = A\nfunc a(a: T) }")
        let resolvedProtocol = resolved as? TypealiasDeclaration
        XCTAssertEqual(resolvedProtocol?.name, "T")
    }

    func test_shouldReturnNilWhenNoTypealias() {
        XCTAssertNil(resolveProtocolParameter(in: "protocol A { func a(a: T) }"))
    }

    func test_shouldReturnNilWhenNoMatchingTypealias() {
        XCTAssertNil(resolveProtocolParameter(in: "protocol A { typealias U = A\nfunc a(a: T) }"))
    }

    func test_shouldResolveWhenManyTypealiases() {
        let resolved = resolveProtocolParameter(in: "protocol A { typealias U = A\ntypealias T = U\nfunc a(a: T) }")
        XCTAssertEqual(resolved?.text, "typealias T = U")
    }

    @discardableResult
    private func resolveParameter(in contents: String) -> Element? {
        let filePath = writeFile(contents)
        let parsedFile = ElementParser.parseFile(at: filePath)!
        let resolver = LocalResolver(spy)
        return resolver.resolve(parsedFile.functionDeclarations[0].parameterClause.parameters[0].typeAnnotation.type)
    }

    @discardableResult
    private func resolveProtocolParameter(in contents: String) -> Element? {
        let filePath = writeFile(contents)
        let parsedFile = ElementParser.parseFile(at: filePath)!
        let resolver = LocalResolver(spy)
        return resolver.resolve(parsedFile.typeDeclarations[0].functionDeclarations[0].parameterClause.parameters[0].typeAnnotation.type)
    }

    private func writeFile(_ contents: String) -> String {
        let writer = TempFileWriterUtil()
        writer.write(contents)
        return writer.tempFile
    }
}
