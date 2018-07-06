import AST
import Resolver
import UseCases

class TypeDeclarationTransformingVisitor: ElementVisitor {

    static func transformMock(_ element: Element, resolver: Resolver) -> UseCasesMockClass {
        let visitor = TypeDeclarationTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return visitor.transformed ?? UseCasesMockClass(superclass: nil, protocols: [], scope: nil)
    }

    private let resolver: Resolver
    private var transformed: UseCasesMockClass?

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
        let protocols = transformInheritanceClause(element)
        transformed = UseCasesMockClass(superclass: nil, protocols: protocols, scope: nil)
    }

    private func transformInheritanceClause(_ element: TypeDeclaration) -> [UseCasesProtocol] {
        let resolved = element.typeInheritanceClause.inheritedTypes
            .compactMap { resolver.resolve($0) as? ProtocolDeclaration }
        return resolved.map { transform($0) }
    }

    private func transform(_ element: TypeDeclaration) -> UseCasesProtocol {
        let visitor = MethodGatheringVisitor(resolver: resolver)
        element.accept(visitor)
        return UseCasesProtocol(
            initializers: visitor.initializers,
            properties: visitor.properties,
            methods: visitor.methods,
            protocols: transformInheritanceClause(element))
    }
}
