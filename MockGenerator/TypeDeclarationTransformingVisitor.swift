import SwiftStructureInterface
import UseCases

class TypeDeclarationTransformingVisitor: ElementVisitor {

    static func transformMock(_ element: Element) -> [UseCasesProtocol] {
        let visitor = TypeDeclarationTransformingVisitor()
        element.accept(visitor)
        return visitor.transformed
    }

    private var transformed = [UseCasesProtocol]()

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
        transformed.append(contentsOf: transformInheritanceClause(element))
    }

    private func transform(_ element: TypeDeclaration) -> UseCasesProtocol {
        let visitor = MethodGatheringVisitor()
        element.accept(visitor)
        return UseCasesProtocol(
            initializers: visitor.initializers,
            properties: visitor.properties,
            methods: visitor.methods)
    }

    private func transformInheritanceClause(_ element: TypeDeclaration) -> [UseCasesProtocol] {
        let resolved = element.inheritedTypes
            .compactMap { ResolveUtil().resolve($0) as? TypeDeclaration }
        return resolved.map { transform($0) } + resolved.flatMap { transformInheritanceClause($0) }
    }
}
