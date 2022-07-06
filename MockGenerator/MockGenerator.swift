import AST
import class UseCases.MockClass
import class UseCases.CallbackMockView
import class UseCases.Generator
import SwiftyKit

protocol MockGenerator {
    var templateName: String { get }
}

extension MockGenerator {

    func generateMock(
        toFile file: Element,
        atElement element: TypeDeclaration
    ) throws {
        let mockClass = transformToMockClass(element: element)
        guard !isEmpty(mockClass: mockClass) else {
            throw error("Could not find a class or protocol on \(element.name)")
        }
        let mockLines = getMockBody(from: mockClass)
        guard !mockLines.isEmpty else {
            throw error("Found inherited types but there was nothing to mock")
        }
        let mockString = mockLines.joined(separator: "\n")
        let mock = "class Mock {\n\(mockString)\n}"
        guard let codeBlock = try? parserFactory.make().parseFile(
            mock,
            url: nil
        ).typeDeclarations.first?.codeBlock
        else {
            throw error("The resulting mock could not be parsed")
        }
        codeBlock.delete()
        element.codeBlock.swap(with: codeBlock)
        formatterFactory.make().format(element)
    }

    private func isEmpty(mockClass: MockClass) -> Bool {
        return mockClass.protocols.isEmpty && mockClass.inheritedClass == nil
    }

    private func getMockBody(from mockClass: MockClass) -> [String] {
        let view = CallbackMockView { [templateName] model in
            let view = MustacheView(templateName: templateName)
            view.render(model: model)
            return view.result
        }
        let generator = Generator(view: view)
        generator.set(c: mockClass)
        generator.generate()
        return view.result
    }

    private func transformToMockClass(element: Element) -> MockClass {
        return TypeDeclarationTransformingVisitor.transformMock(element, resolver: resolverFactory.make())
    }
}
