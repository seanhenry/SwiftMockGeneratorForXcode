import AST
import Resolver
import UseCases

class TypeDeclarationTransformingVisitor: ElementVisitor {

    static func transformMock(_ element: Element, resolver: Resolver) -> UseCasesMockClass {
        let visitor = TypeDeclarationTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return visitor.transformed ?? UseCasesMockClass(inheritedClass: nil, protocols: [], scope: nil)
    }

    private let resolver: Resolver
    private var transformed: UseCasesMockClass?

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    override func visitClassDeclaration(_ element: ClassDeclaration) {
        let superclass = transformInheritedClass(element)
        let protocols = transformImplementedProtocols(element)
        transformed = UseCasesMockClass(inheritedClass: superclass, protocols: protocols, scope: nil)
    }

    private func transformImplementedProtocols(_ element: TypeDeclaration) -> [UseCasesProtocol] {
        let resolved = element.typeInheritanceClause?.inheritedTypes
            .filter { $0.text != "NSObjectProtocol" }
            .compactMap { resolver.resolve($0) as? ProtocolDeclaration }
        return resolved?.map { transform($0) } ?? []
    }

    private func transform(_ element: ProtocolDeclaration) -> UseCasesProtocol {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return UseCasesProtocol(
            initializers: visitor.initializers,
            properties: visitor.properties,
            methods: visitor.methods,
            protocols: transformImplementedProtocols(element))
    }

    private func transformInheritedClass(_ element: TypeDeclaration) -> UseCasesClass? {
        guard let firstInheritedType = element.typeInheritanceClause?.inheritedTypes.first else {
            return nil
        }
        if firstInheritedType.text == "NSObject" {
            return UseCasesClassBuilder()
                    .initializer { _ in UseCasesStdlibUnit() }
                    .build()
        }
        let resolved = resolver.resolve(firstInheritedType) as? ClassDeclaration
        return resolved.map { transform($0) }
    }

    private func transform(_ element: ClassDeclaration) -> UseCasesClass {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return UseCasesClass(
                initializers: visitor.initializers,
                properties: visitor.properties,
                methods: visitor.methods,
                inheritedClass: transformInheritedClass(element))
    }
}
