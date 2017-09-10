import Foundation
@testable import SwiftStructureInterface
import SourceKittenFramework

public class Generator {
    
    public static func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int) -> ([String]?, Error?) {
        // TODO: put files elsewhere
        ResolveUtil.files = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        // TODO: fully encapsulate SourceKitten
        let structure = Structure(file: File(contents: contents))
        let file = StructureBuilder(data: structure.dictionary, fileText: contents).build()
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: contents) else {
            return reply(with: "cursor not found")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: file, cursorOffset: cursorOffset) else {
            return reply(with: "elementUnderCaret not found")
        }
        guard let typeElement = elementUnderCaret as? SwiftTypeElement,
            let inheritedType = typeElement.inheritedTypes.first else {
                return reply(with: "No inheritedType")
        }
        if let resolved = ResolveUtil().resolve(inheritedType) {
            return buildMock(toFile: file, atElement: typeElement, resolvedProtocol: resolved)
        } else {
            return reply(with: "\(inheritedType.name) element could not be resolved")
        }
    }
    
    private static func reply(with message: String) -> ([String]?, Error?) {
        let nsError = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    private static func buildMock(toFile file: Element, atElement element: SwiftTypeElement, resolvedProtocol: Element) -> ([String]?, Error?) {
        let mockLines = getMockBody(fromResolvedProtocol: resolvedProtocol)
        guard let (newFile, newTypeElement) = delete(contentsOf: element) else {
            return reply(with: "Could not delete body from: \(element.text)")
        }
        let fileLines = insert(mockLines, atTypeElement: newTypeElement, in: newFile)
        return (format(fileLines), nil)
    }
    
    private static func getMockBody(fromResolvedProtocol resolvedProtocol: Element) -> [String] {
        let environment = JavaEnvironment.shared
        let generator = JavaXcodeMockGeneratorBridge(javaEnvironment: environment)
        let visitor = MethodGatheringVisitor(environment: environment)
        resolvedProtocol.accept(RecursiveElementVisitor(visitor: visitor))
        visitor.properties.forEach { generator.addProtocolProperty($0) }
        visitor.methods.forEach { generator.addProtocolMethod($0) }
        let mockString = generator.generate()
        return mockString.components(separatedBy: .newlines)
    }
    
    private static func delete(contentsOf typeElement: SwiftTypeElement) -> (SwiftFile, SwiftTypeElement)? {
        guard let (newFile, newTypeElement) = DeleteBodyUtil().deleteClassBody(from: typeElement) as? (SwiftFile, SwiftTypeElement) else {
            return nil
        }
        return (newFile, newTypeElement)
    }
    
    private static func insert(_ mockBody: [String], atTypeElement typeElement: SwiftTypeElement, in file: Element) -> [String] {
        var fileLines = file.text.components(separatedBy: .newlines)
        let lineColumn = LocationConverter.convert(caretOffset: typeElement.bodyOffset + typeElement.bodyLength, in: file.text)!
        let insertIndex = lineColumn.line
        fileLines.insert(contentsOf: mockBody, at: insertIndex)
        return fileLines
    }
    
    private static func format(_ lines: [String]) -> [String] {
        let newFileText = lines.joined(separator: "\n")
        let dictionary = Structure(file: File(contents: newFileText)).dictionary
        let newFile = StructureBuilder(data: dictionary, fileText: newFileText).build()
        let formatted = FormatUtil().format(newFile).text
        return formatted.components(separatedBy: .newlines)
    }
}
