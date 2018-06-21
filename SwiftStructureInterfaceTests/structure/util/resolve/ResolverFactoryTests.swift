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

    private func writeFile(_ contents: String) -> String {
        let writer = TempFileWriterUtil()
        writer.write(contents)
        return writer.tempFile
    }

    private func resolveParameterType(_ parsedFile: File, at index: Int) -> Element? {
        let type = parsedFile.functionDeclarations[index].parameters[0].typeAnnotation.type
        return resolver.resolve(type)
    }
}
