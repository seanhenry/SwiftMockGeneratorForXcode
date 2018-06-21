import XCTest
@testable import SwiftStructureInterface

class ResolverFactoryTests: XCTestCase {

    var resolver: Resolver!

    func test_shouldNotCacheGenericArgumentInCaseItHasTheSameNameAsAnotherType() {
        let filePath1 = writeFile("func a<T>(a: T) {}\nfunc b(b: T){}")
        let filePath2 = writeFile("protocol T {}")
        let parsedFile = ElementParser.parseFile(at: filePath1)!
        resolver = ResolverFactory.createResolver(filePaths: [filePath1, filePath2])
        XCTAssert(resolveParameterType(parsedFile, at: 0) is GenericParameter)
        XCTAssert(resolveParameterType(parsedFile, at: 1) is TypeDeclaration)
    }

    func test_shouldNotCacheTypealiasArgumentInCaseItHasTheSameNameAsAnotherType() {
        let filePath1 = writeFile("protocol A { typealias T = A\nfunc a(a: T) }")
        let filePath2 = writeFile("func b(b: T)")
        let filePath3 = writeFile("protocol T {}")
        let parsedProtocol = ElementParser.parseFile(at: filePath1)!.typeDeclarations[0]
        resolver = ResolverFactory.createResolver(filePaths: [filePath1, filePath2, filePath3])
        XCTAssert(resolveParameterType(parsedProtocol, at: 0) is Typealias)
        let parsedFile = ElementParser.parseFile(at: filePath2)!
        XCTAssert(resolveParameterType(parsedFile, at: 0) is TypeDeclaration)
    }

    private func writeFile(_ contents: String) -> String {
        let writer = TempFileWriterUtil()
        writer.write(contents)
        return writer.tempFile
    }

    private func resolveParameterType(_ element: Declarations, at index: Int) -> Element? {
        let type = element.functionDeclarations[index].parameters[0].typeAnnotation.type
        return resolver.resolve(type)
    }
}
