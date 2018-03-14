import UseCases
import SwiftStructureInterface

class TypeResolverVisitor: ElementVisitor {

    var transformedType: String?
    var resolvedType: String?
    private let resolveUtil: ResolveUtil

    init(resolveUtil: ResolveUtil) {
        self.resolveUtil = resolveUtil
    }

    override func visitType(_ element: Type) {
        guard let resolved = self.resolveUtil.resolve(element) else { return }
        let visitor = ResolvedVisitor(resolveUtil: resolveUtil)
        resolved.accept(visitor)
        transformedType = visitor.transformedType
        resolvedType = visitor.resolvedType ?? element.text
    }

    override func visitArrayType(_ element: ArrayType) {
        let resolved = resolveType(element.elementType)
        transformedType = "[\(resolved.transformedType ?? element.elementType.text)]"
        if let r = resolved.resolvedType {
            resolvedType = "[\(r)]"
        }
    }

    override func visitDictionaryType(_ element: DictionaryType) {
        let resolvedKeyType = resolveType(element.keyType)
        let resolvedValueType = resolveType(element.valueType)
        transformedType = "[\(resolvedKeyType.transformedType?.appending("Hashable") ?? element.keyType.text): \(resolvedValueType.transformedType ?? element.valueType.text)]"
        if resolvedKeyType.resolvedType == nil && resolvedValueType.resolvedType == nil {
            return
        }
        resolvedType = "[\(resolvedKeyType.resolvedType ?? element.keyType.text): \(resolvedValueType.resolvedType ?? element.valueType.text)]"
    }

    override func visitOptionalType(_ element: OptionalType) {
        let resolved = resolveType(element.type)
        transformedType = "\(resolved.transformedType ?? element.type.text)?"
        if let r = resolved.resolvedType {
            resolvedType = "\(r)?"
        }
    }

    private func resolveType(_ element: Type) -> (transformedType: String?, resolvedType: String?) {
        let visitor = TypeResolverVisitor(resolveUtil: resolveUtil)
        element.accept(visitor)
        return (visitor.transformedType, visitor.resolvedType)
    }

    private class ResolvedVisitor: ElementVisitor {

        let resolveUtil: ResolveUtil
        var transformedType: String?
        var resolvedType: String?

        init(resolveUtil: ResolveUtil) {
            self.resolveUtil = resolveUtil
        }

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            transformedType = "Any"
        }

        override func visitTypealias(_ element: Typealias) {
            resolvedType = element.typealiasAssignment.type.text
            if let resolved = ResolveUtil().resolve(element.typealiasAssignment.type) {
                resolved.accept(self)
            }
        }
    }
}
