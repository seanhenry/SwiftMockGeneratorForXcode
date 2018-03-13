import UseCases
@testable import SwiftStructureInterface

class GenericTypeTransformerVisitor: ElementVisitor {

    var type: UseCasesType?
    private let resolveUtil: ResolveUtil

    init(resolveUtil: ResolveUtil) {
        self.resolveUtil = resolveUtil
    }

    override func visitType(_ element: Type) {
        if isResolvedAsGenericParameter(element) {
            type = UseCasesType(typeName: "Any")
        } else {
            type = UseCasesType(typeName: element.text)
        }
    }

    override func visitArrayType(_ element: ArrayType) {
        if isResolvedAsGenericParameter(element.elementType) {
            type = UseCasesType(typeName: "[Any]")
        } else {
            type = UseCasesType(typeName: element.text)
        }
    }

    private func isResolvedAsGenericParameter(_ type: Type) -> Bool {
        guard let resolved = self.resolveUtil.resolve(type) else { return false }
        let visitor = GenericVisitor()
        resolved.accept(visitor)
        return visitor.isGenericParameterClause
    }

    private class GenericVisitor: ElementVisitor {

        var isGenericParameterClause = false

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            isGenericParameterClause = true
        }
    }
}
