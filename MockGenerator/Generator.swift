import Foundation
@testable import SwiftStructureInterface
import SourceKittenFramework

public class Generator {
    
    public static func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int) -> ([String]?, Error?) {
        
        // TODO: put files elsewhere
        ResolveUtil.files = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        // TODO: fully encapsulate SourceKitten
        let structure = Structure(file: File(contents: contents))
        let element = StructureBuilder(data: structure.dictionary, text: contents).build()
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: contents) else {
            return reply(with: "cursor not found")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: element, cursorOffset: cursorOffset) else {
            return reply(with: "elementUnderCaret not found")
        }
        guard let typeElement = elementUnderCaret as? SwiftTypeElement,
            let inheritedType = typeElement.inheritedTypes.first else {
                return reply(with: "No inheritedType")
        }
        guard let (newFile, newTypeElement) = DeleteBodyUtil().deleteClassBody(from: typeElement) as? (SwiftFile, SwiftTypeElement) else {
            return reply(with: "Could not delete body from: \(String(describing: typeElement.file?.text))")
        }
        if let resolved = ResolveUtil().resolve(inheritedType) {
            let visitor = MethodGatheringVisitor()
            resolved.accept(RecursiveElementVisitor(visitor: visitor))
            return buildMock(toFile: newFile, atElement: newTypeElement, methodNames: visitor.methodNames)
        } else {
            return reply(with: "\(inheritedType.name) element not found at: \(inheritedType.offset)")
        }
    }
    
    private static func reply(with message: String) -> ([String]?, Error?) {
        let nsError = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    // TODO: remove these responsibilities from the extension
    private static func buildMock(toFile file: Element, atElement element: SwiftTypeElement, methodNames: [String]) -> ([String]?, Error?) {

        let environment = JavaEnvironment()
        let generator = JavaXcodeMockGeneratorBridge(javaEnvironment: environment)
        for methodName in methodNames {
            let method = JavaProtocolMethodBridge(javaEnvironment: environment, name: methodName)
            generator.addProtocolMethod(method)
        }
        let mockString = generator.generate()
        let mockLines = mockString.components(separatedBy: .newlines)
        
        var fileLines = file.text.components(separatedBy: .newlines)
        let lineColumn = LocationConverter.convert(caretOffset: element.bodyOffset + element.bodyLength, in: file.text)!
        let insertIndex = lineColumn.line
        fileLines.insert(contentsOf: mockLines, at: insertIndex)
        return (format(fileLines), nil)
    }
    
    private static func format(_ lines: [String]) -> [String] {
        let newFileText = lines.joined(separator: "\n")
        let dictionary = Structure(file: File(contents: newFileText)).dictionary
        let newFile = StructureBuilder(data: dictionary, text: newFileText).build()
        let formatted = FormatUtil().format(newFile).text
        return formatted.components(separatedBy: .newlines)
    }
}
