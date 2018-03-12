import UseCases
@testable import SwiftStructureInterface

class GenericTypeTransformerVisitor: ElementVisitor {

    var type: UseCasesType?
    private let resolveUtil: ResolveUtil

    init(resolveUtil: ResolveUtil) {
        self.resolveUtil = resolveUtil
    }

    override func visitType(_ element: Type) {
        type = UseCasesType(typeName: element.text)
        guard let resolved = self.resolveUtil.resolve(element) else { return }
        let visitor = GenericVisitor()
        resolved.accept(visitor)
        if visitor.isGenericParameterClause {
            type = UseCasesGenericType(typeName: "Any")
        }
    }

    private class GenericVisitor: ElementVisitor {

        var isGenericParameterClause = false

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            isGenericParameterClause = true
        }
    }
}
