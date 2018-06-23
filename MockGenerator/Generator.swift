import Foundation
import UseCases
import SwiftStructureInterface

public class Generator {

    public static func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, templateName: String) -> (BufferInstructions?, Error?) {
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

    private static func reply(with message: String) -> (BufferInstructions?, Error?) {
        let nsError = NSError(domain: "MockGenerator.Generator", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    private static func buildMock(toFile file: Element, atElement element: TypeDeclaration, templateName: String, resolver: Resolver) -> (BufferInstructions?, Error?) {
        let mockLines = getMockBody(from: element, templateName: templateName, resolver: resolver)
        guard !mockLines.isEmpty else {
            return reply(with: "Could not find a protocol on \(element.name)")
        }
        let formatted = format(mockLines, relativeTo: element).map { "\($0)\n" }
        guard let instructions = BufferInstructionsFactory().create(mockClass: element, lines: formatted) else {
            return reply(with: "Could not delete body from: \(element.text)")
        }
        return (instructions, nil)
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
    
    private static func format(_ lines: [String], relativeTo element: Element) -> [String] {
        return FormatUtil(useTabs: false, spaces: 4).format(lines, in: element)
    }
}
