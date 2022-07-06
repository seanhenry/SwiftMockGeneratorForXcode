import AST
import SwiftyKit
import UseCases
import class UseCases.Class

class TypeDeclarationTransformingVisitor: ElementVisitor {

    static func transformMock(_ element: AST.Element, resolver: Resolver) -> MockClass {
        let visitor = TypeDeclarationTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return visitor.transformed ?? MockClass(inheritedClass: nil, protocols: [], scope: nil)
    }

    private let resolver: Resolver
    private var transformed: MockClass?

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    override func visitClassDeclaration(_ element: ClassDeclaration) {
        let superclass = transformInheritedClass(element)
        let protocols = transformImplementedProtocols(element)
        transformed = MockClass(inheritedClass: superclass, protocols: protocols, scope: nil)
    }

    private func transformImplementedProtocols(_ element: AST.TypeDeclaration) -> [`Protocol`] {
        let resolved = element.typeInheritanceClause?.inheritedTypes
            .filter { $0.text != "NSObjectProtocol" }
            .compactMap { resolver.resolve($0) as? ProtocolDeclaration }
        return resolved?.map { transform($0) } ?? []
    }

    private func transform(_ element: ProtocolDeclaration) -> `Protocol` {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return `Protocol`(
            initializers: visitor.initializers,
            properties: visitor.properties,
            methods: visitor.methods,
            subscripts: visitor.subscripts,
            protocols: transformImplementedProtocols(element))
    }

    private func transformInheritedClass(_ element: AST.TypeDeclaration) -> Class? {
        guard let firstInheritedType = element.typeInheritanceClause?.inheritedTypes.first else {
            return nil
        }
        if firstInheritedType.text == "NSObject" {
            return UseCases.Class(
                initializers: [UseCases.Initializer(parametersList: [], isFailable: false, throws: false)],
                properties: [],
                methods: [],
                subscripts: [],
                inheritedClass: nil
            )
        }
        let resolved = resolver.resolve(firstInheritedType) as? ClassDeclaration
        return resolved.map { transform($0) }
    }

    private func transform(_ element: ClassDeclaration) -> Class {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return Class(
                initializers: visitor.initializers,
                properties: visitor.properties,
                methods: visitor.methods,
                subscripts: visitor.subscripts,
                inheritedClass: transformInheritedClass(element))
    }
}
