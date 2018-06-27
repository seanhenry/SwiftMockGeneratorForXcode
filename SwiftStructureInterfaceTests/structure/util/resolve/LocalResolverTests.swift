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
        XCTAssert(try resolveParameter(in: "func a(a: T)") === testElement)
    }

    func test_shouldReturnGenericParameterWhenTypeResolvesToOne() throws {
        let resolved = try resolveParameter(in: "func a<T>(a: T)")
        XCTAssert(resolved is GenericParameter)
        XCTAssertEqual(resolved?.text, "T")
    }

    func test_shouldReturnNilWhenNoParameterClause() {
        XCTAssertNil(try resolveParameter(in: "func a(a: T)"))
    }

    func test_shouldReturnNilWhenNoMatchingGenericParameter() {
        XCTAssertNil(try resolveParameter(in: "func a<U>(a: T)"))
    }

    func test_shouldReturnGenericParameterWhenManyParameters() {
        XCTAssertEqual(try resolveParameter(in: "func a<U: Y, V, T: Z>(a: T)")?.text, "T: Z")
    }

    func test_shouldResolveProtocolTypealias() throws {
        let resolved = try resolveProtocolParameter(in: "protocol A { typealias T = A\nfunc a(a: T) }")
        let resolvedProtocol = resolved as? TypealiasDeclaration
        XCTAssertEqual(resolvedProtocol?.name, "T")
    }

    func test_shouldReturnNilWhenNoTypealias() {
        XCTAssertNil(try resolveProtocolParameter(in: "protocol A { func a(a: T) }"))
    }

    func test_shouldReturnNilWhenNoMatchingTypealias() {
        XCTAssertNil(try resolveProtocolParameter(in: "protocol A { typealias U = A\nfunc a(a: T) }"))
    }

    func test_shouldResolveWhenManyTypealiases() throws {
        let resolved = try resolveProtocolParameter(in: "protocol A { typealias U = A\ntypealias T = U\nfunc a(a: T) }")
        XCTAssertEqual(resolved?.text, "typealias T = U")
    }

    @discardableResult
    private func resolveParameter(in contents: String) throws -> Element? {
        let filePath = writeFile(contents)
        let parsedFile = try ElementParser.parseFile(at: filePath)
        let resolver = LocalResolver(spy)
        return resolver.resolve(parsedFile.functionDeclarations[0].parameterClause.parameters[0].typeAnnotation.type)
    }

    @discardableResult
    private func resolveProtocolParameter(in contents: String) throws -> Element? {
        let filePath = writeFile(contents)
        let parsedFile = try ElementParser.parseFile(at: filePath)
        let resolver = LocalResolver(spy)
        return resolver.resolve(parsedFile.typeDeclarations[0].functionDeclarations[0].parameterClause.parameters[0].typeAnnotation.type)
    }

    private func writeFile(_ contents: String) -> String {
        let writer = TempFileWriterUtil()
        writer.write(contents)
        return writer.tempFile
    }
}
