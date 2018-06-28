//import XCTest
//@testable import SwiftStructureInterface
//
//class SKResolverTests: XCTestCase {
//
//    var resolver: Resolver!
//    var spy: ResolverSpy!
//    var resolveFile: String!
//    var resolvedFile: String!
//
//    override func setUp() {
//        super.setUp()
//        spy = ResolverSpy()
//        // SourceKit caches files
//        resolveFile = NSTemporaryDirectory() + UUID().uuidString + "_resolve.swift"
//        resolvedFile = NSTemporaryDirectory() + UUID().uuidString + "_resolved.swift"
//    }
//
//    override func tearDown() {
//        resolver = nil
//        resolveFile = nil
//        resolvedFile = nil
//        super.tearDown()
//    }
//
//    func test_resolve_shouldResolveElementInSameFile() {
//        resolver = createSameFileResolver()
//        writeResolveClassesToSingleFile()
//        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
//        let reference = file.typeDeclarations[1].typeInheritanceClause.inheritedTypes[0]
//        let resolved = resolver.resolve(reference) as? TypeDeclaration
//        XCTAssertEqual(resolved?.name, "ResolveTest")
//        let method = resolved?.functionDeclarations[0]
//        XCTAssertEqual(method?.name, "method")
//    }
//
//    func test_resolve_shouldResolveSwiftTypeDeclaration() {
//        resolver = createManyFileResolver()
//        writeResolveClassesToFile()
//        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
//        let reference = file.typeDeclarations[0].typeInheritanceClause.inheritedTypes[0]
//        let resolved = resolver.resolve(reference) as? TypeDeclaration
//        XCTAssertEqual(resolved?.name, "ResolveTest")
//        let method = resolved?.functionDeclarations[0]
//        XCTAssertEqual(method?.name, "method")
//    }
//
//    func test_resolve_shouldResolveElementWithUTF16Characters() {
//        resolver = createManyFileResolver()
//        writeUTF16ResolveClassesToFile()
//        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
//        let reference = file.typeDeclarations[0].typeInheritanceClause.inheritedTypes[0]
//        let resolved = resolver.resolve(reference) as? TypeDeclaration
//        XCTAssertEqual(resolved?.name, "Resolve💐Test")
//        let method = resolved?.functionDeclarations[0]
//        XCTAssertEqual(method?.name, "method💐")
//    }
//
//    func test_resolve_shouldReturnNil_whenNoCursorInfo() {
//        resolver = createThrowingSameFileResolver()
//        writeResolveClassesToFile()
//        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
//        let reference = file.typeDeclarations[0].typeInheritanceClause.inheritedTypes[0]
//        XCTAssertNil(resolver.resolve(reference))
//    }
//
//    func test_resolve_shouldCallDecoratorWhenCannotResolveAnElement() {
//        resolver = createSpyingResolver()
//        _ = resolver.resolve(testElement)
//        XCTAssert(spy.invokedResolve)
//    }
//
//    func test_resolve_shouldCallNotCallDecoratorWhenResolves() {
//        resolver = createSpyingResolver()
//        writeResolveClassesToSingleFile()
//        let file = SKElementFactoryTestHelper.build(fromPath: resolveFile)!
//        let reference = file.typeDeclarations[1].typeInheritanceClause.inheritedTypes[0]
//        _ = resolver.resolve(reference)
//        XCTAssertFalse(spy.invokedResolve)
//    }
//
//    // MARK: - Helpers
//
//    private func createSameFileResolver() -> Resolver {
//        return createResolver(ResolverDecoratorDummy(), SKCursorInfoRequest(files: []))
//    }
//
//    private func createManyFileResolver() -> Resolver {
//        return createResolver(ResolverDecoratorDummy(), SKCursorInfoRequest(files: [resolveFile, resolvedFile]))
//    }
//
//    private func createThrowingSameFileResolver() -> Resolver {
//        return createResolver(ResolverDecoratorDummy(), ThrowingCursorInfoRequest())
//    }
//
//    private func createSpyingResolver() -> Resolver {
//        return createResolver(spy, SKCursorInfoRequest(files: []))
//    }
//
//    private func createResolver(_ decorator: Resolver?, _ cursorInfoRequest: CursorInfoRequest) -> Resolver {
//        let writer = TempFileWriterUtil()
//        let resolver = SKResolver(decorator, cursorInfoRequest: cursorInfoRequest, fileWriter: writer)
//        return WriteFileResolver(resolver, fileWriter: writer)
//    }
//
//    private func writeResolveClassesToSingleFile() {
//        try! getResolveClassAndProtocolString().data(using: .utf8)!
//                .write(to: URL(fileURLWithPath: resolveFile))
//    }
//
//    private func getResolveClassAndProtocolString() -> String {
//        return """
//        protocol ResolveTest {
//
//            func method() {}
//        }
//        class MockResolveTest: ResolveTest { }
//        """
//    }
//
//    class ThrowingCursorInfoRequest: CursorInfoRequest {
//        class Error: Swift.Error {}
//        func getCursorInfo(filePath: String, offset: Int64) throws -> [String: Any] {
//            throw Error()
//        }
//    }
//
//    private func writeResolveClassesToFile() {
//        try! getResolveClassString().data(using: .utf8)!
//                .write(to: URL(fileURLWithPath: resolveFile))
//        try! getResolvedProtocolString().data(using: .utf8)!
//                .write(to: URL(fileURLWithPath: resolvedFile))
//    }
//
//    private func getResolveClassString() -> String {
//        return """
//class MockResolveTest: ResolveTest { }
//"""
//    }
//
//    private func getResolvedProtocolString() -> String {
//        return """
//protocol ResolveTest {
//
//  func method() {}
//}
//"""
//    }
//
//    private func writeUTF16ResolveClassesToFile() {
//        try! getUTF16ResolveClassString().data(using: .utf8)!
//                .write(to: URL(fileURLWithPath: resolveFile))
//        try! getUTF16ResolvedProtocolString().data(using: .utf8)!
//                .write(to: URL(fileURLWithPath: resolvedFile))
//    }
//
//    private func getUTF16ResolveClassString() -> String {
//        return """
//class MockResolve💐Test: Resolve💐Test { }
//"""
//    }
//
//    private func getUTF16ResolvedProtocolString() -> String {
//        return """
//protocol Resolve💐Test {
//
//  func method💐() {}
//}
//"""
//    }
//}
