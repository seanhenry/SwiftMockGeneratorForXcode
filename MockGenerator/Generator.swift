import Foundation
import UseCases
import SwiftStructureInterface

public class Generator {

    private let fileContents: String
    private let line: Int
    private let column: Int
    private let templateName: String
    private let useTabsForIndentation: Bool
    private let indentationWidth: Int
    private let resolver: Resolver

    public init(fromFileContents fileContents: String,
                projectURL: URL,
                line: Int,
                column: Int,
                templateName: String,
                useTabsForIndentation: Bool,
                indentationWidth: Int) {
        self.fileContents = fileContents
        self.line = line
        self.column = column
        self.templateName = templateName
        self.useTabsForIndentation = useTabsForIndentation
        self.indentationWidth = indentationWidth
        let sourceFiles = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        self.resolver = ResolverFactory.createResolver(filePaths: sourceFiles)
    }

    public func generateMock() -> (BufferInstructions?, Error?) {
        let file = ElementParser.parseFile(fileContents)
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: fileContents) else {
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
        return buildMock(toFile: file, atElement: typeElement)
    }

    private func reply(with message: String) -> (BufferInstructions?, Error?) {
        let nsError = NSError(domain: "MockGenerator.Generator", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    private func buildMock(toFile file: Element, atElement element: TypeDeclaration) -> (BufferInstructions?, Error?) {
        let mockLines = getMockBody(from: element)
        guard !mockLines.isEmpty else {
            return reply(with: "Could not find a protocol on \(element.name)")
        }
        let formatted = format(mockLines, relativeTo: element).map { "\($0)\n" }
        guard let instructions = BufferInstructionsFactory().create(mockClass: element, lines: formatted) else {
            return reply(with: "Could not delete body from: \(element.text)")
        }
        return (instructions, nil)
    }
    
    private func getMockBody(from element: Element) -> [String] {
        let templateName = self.templateName
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
    
    private func format(_ lines: [String], relativeTo element: Element) -> [String] {
        return FormatUtil(useTabs: useTabsForIndentation, spaces: indentationWidth)
                .format(lines, relativeTo: element)
    }
}
