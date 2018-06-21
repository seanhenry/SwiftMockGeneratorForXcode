import Foundation
import UseCases
import SwiftStructureInterface

public class Generator {

    public static func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, templateName: String) -> ([String]?, Error?) {
        let sourceFiles = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        let resolver = ResolverFactory.createResolver(filePaths: sourceFiles)
        guard let file = SKElementFactory().build(from: contents) else {
            return reply(with: "Could not parse Swift file")
        }
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: contents) else {
            return reply(with: "Could not get the cursor position")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: file, cursorOffset: cursorOffset) else {
            return reply(with: "No Swift element found under the cursor")
        }
        guard let typeElement = (elementUnderCaret as? TypeDeclaration) ?? ElementTreeUtil().findParentType(elementUnderCaret) else {
            return reply(with: "Place the cursor on a mock class declaration")
        }
        guard typeElement.inheritedTypes.count > 0 else {
            return reply(with: "MockClass must implement at least 1 protocol")
        }
        return buildMock(toFile: file, atElement: typeElement, templateName: templateName, resolver: resolver)
    }

    private static func reply(with message: String) -> ([String]?, Error?) {
        let nsError = NSError(domain: "MockGenerator.Generator", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    private static func buildMock(toFile file: Element, atElement element: TypeDeclaration, templateName: String, resolver: Resolver) -> ([String]?, Error?) {
        let mockLines = getMockBody(from: element, templateName: templateName, resolver: resolver)
        guard !mockLines.isEmpty else {
            return reply(with: "Could not find a protocol on \(element.name)")
        }
        guard let (newFile, newTypeElement) = delete(contentsOf: element) else {
            return reply(with: "Could not delete body from: \(element.text)")
        }
        let fileLines = insert(mockLines, atTypeElement: newTypeElement, in: newFile)
        return (format(fileLines), nil)
    }
    
    private static func getMockBody(from element: Element, templateName: String, resolver: Resolver) -> [String] {
        let view = UseCasesCallbackMockView { model in
            let view = MustacheView(templateName: templateName)
            view.render(model: model)
            return view.result
        }
        let generator = UseCasesGenerator(view: view)
        generator.set(c: TypeDeclarationTransformingVisitor.transformMock(element, resolver: resolver))
        generator.generate()
        return view.result
    }
    
    private static func delete(contentsOf typeElement: TypeDeclaration) -> (File, TypeDeclaration)? {
        guard let (newFile, newTypeElement) = DeleteBodyUtil().deleteClassBody(from: typeElement) as? (File, TypeDeclaration) else {
            return nil
        }
        return (newFile, newTypeElement)
    }
    
    private static func insert(_ mockBody: [String], atTypeElement typeElement: TypeDeclaration, in file: Element) -> [String] {
        var fileLines = file.text.getLines()
        let lineColumn = LocationConverter.convert(caretOffset: typeElement.bodyOffset + typeElement.bodyLength, in: file.text)!
        let zeroBasedLine = lineColumn.line - 1
        let insertIndex = zeroBasedLine
        fileLines.insert(contentsOf: mockBody, at: insertIndex)
        return fileLines
    }
    
    private static func format(_ lines: [String]) -> [String] {
        let newFileText = lines.joined(separator: "\n")
        guard let newFile = SKElementFactory().build(from: newFileText) else { return lines }
        FormatUtil.formatRequest = SKFormatRequest()
        let formatted = FormatUtil().format(newFile).text
        return formatted.getLines()
    }
}
