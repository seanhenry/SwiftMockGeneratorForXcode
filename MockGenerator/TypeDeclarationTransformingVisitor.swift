import SwiftStructureInterface
import UseCases

class TypeDeclarationTransformingVisitor: ElementVisitor {

    static func transformMock(_ element: Element) -> UseCasesMockClass {
        let visitor = TypeDeclarationTransformingVisitor()
        element.accept(visitor)
        return visitor.transformed ?? UseCasesMockClass(superclass: nil, protocols: [], scope: nil)
    }

    private var transformed: UseCasesMockClass?

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
        let protocols = transformInheritanceClause(element)
        transformed = UseCasesMockClass(superclass: nil, protocols: protocols, scope: nil)
    }

    private func transformInheritanceClause(_ element: TypeDeclaration) -> [UseCasesProtocol] {
        let resolved = element.inheritedTypes
            .compactMap { ResolveUtil().resolve($0) as? TypeDeclaration }
        return resolved.map { transform($0) }
    }

    private func transform(_ element: TypeDeclaration) -> UseCasesProtocol {
        let visitor = MethodGatheringVisitor()
        element.accept(visitor)
        return UseCasesProtocol(
            initializers: visitor.initializers,
            properties: visitor.properties,
            methods: visitor.methods,
            protocols: transformInheritanceClause(element))
    }
}
