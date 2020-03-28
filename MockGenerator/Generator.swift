import Foundation
import UseCases
import AST
import Resolver
import Algorithms
import SwiftyKit
import Formatter

public class Generator: ASTCommandImpl {

    public override var name: String { "Mock Generator" }

    public override var identifier: String { "codes.seanhenry.mockgenerator" }

    private let templateName: String
    private let useTabsForIndentation: Bool
    private let indentationWidth: Int
    private let resolver: Resolver
    private let trackLines: (Int) -> Void

    public init(
        projectURL: URL,
        templateName: String,
        useTabsForIndentation: Bool,
        indentationWidth: Int,
        trackLines: @escaping (Int) -> Void
    ) {
        self.templateName = templateName
        self.useTabsForIndentation = useTabsForIndentation
        self.indentationWidth = indentationWidth
        let sourceFiles = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        self.resolver = ResolverFactory.createResolver(filePaths: Generator.filterUniqueFileNames(sourceFiles))
        self.trackLines = trackLines
        super.init()
    }

    private static func filterUniqueFileNames(_ fileNames: [URL]) -> [String] {
        var sourceFileSet = Set<String>()
        return fileNames.map { file in
            (file.path, file.lastPathComponent)
        }.compactMap { (file, name) in
            if sourceFileSet.contains(name) {
                return nil
            }
            sourceFileSet.insert(name)
            return file
        }
    }

    private func error(_ description: String) -> Error {
        return NSError(domain: "MockGenerator", code: 1, userInfo: [NSLocalizedDescriptionKey: description])
    }

    public override func execute(buffer: TextBuffer, file: File) throws {
        guard let selection = buffer.selectionRange.first?.start else {
            throw error("No selections. Place the cursor on a mock class declaration")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: file, line: selection.line, column: selection.column, type: Element.self) else {
            throw error("No Swift element found under the cursor")
        }
        guard let typeElement = (elementUnderCaret as? TypeDeclaration) ?? ElementTreeUtil().findParentType(elementUnderCaret) else {
            throw error("Place the cursor on a mock class declaration")
        }
        guard let types = typeElement.typeInheritanceClause?.inheritedTypes, types.count > 0 else {
            throw error("MockClass must inherit from a class or implement at least 1 protocol")
        }
        try buildMock(toFile: file, atElement: typeElement)
    }
    
    private func buildMock(toFile file: Element, atElement element: TypeDeclaration) throws  {
        let mockClass = transformToMockClass(element: element)
        guard !isEmpty(mockClass: mockClass) else {
            throw error("Could not find a class or protocol on \(element.name)")
        }
        let mockLines = getMockBody(from: mockClass)
        guard !mockLines.isEmpty else {
            throw error("Found inherited types but there was nothing to mock")
        }
        let formatted = format(mockLines, relativeTo: element).joined(separator: "\n")
        let mock = "class Mock {\n\(formatted)\n}"
        guard let codeBlock = try? parserFactory.make().parseFile(mock, url: nil).typeDeclarations.first?.codeBlock else {
            throw error("The resulting mock could not be parsed")
        }
        trackLines(mockLines.count)
        codeBlock.delete()
        element.codeBlock.swap(with: codeBlock)
    }

    private func isEmpty(mockClass: UseCasesMockClass) -> Bool {
        return mockClass.protocols.isEmpty && mockClass.inheritedClass == nil
    }

    private func getMockBody(from mockClass: UseCasesMockClass) -> [String] {
        let templateName = self.templateName
        let view = UseCasesCallbackMockView { model in
            let view = MustacheView(templateName: templateName)
            view.render(model: model)
            return view.result
        }
        let generator = UseCasesGenerator(view: view)
        generator.set(c: mockClass)
        generator.generate()
        return view.result
    }

    private func transformToMockClass(element: Element) -> UseCasesMockClass {
        return TypeDeclarationTransformingVisitor.transformMock(element, resolver: resolver)
    }

    private func format(_ lines: [String], relativeTo element: Element) -> [String] {
        return FormatUtil(useTabs: useTabsForIndentation, spaces: indentationWidth)
                .format(lines, relativeTo: element)
    }
}
