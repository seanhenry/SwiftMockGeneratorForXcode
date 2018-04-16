import UseCases
import SwiftStructureInterface

class TypeResolverVisitor: ElementVisitor {

    var resolvedType: Type?
    private let resolveUtil: ResolveUtil

    init(resolveUtil: ResolveUtil) {
        self.resolveUtil = resolveUtil
    }

    override func visitType(_ element: Type) {
        guard let resolved = self.resolveUtil.resolve(element) else { return }
        let visitor = ResolvedVisitor(resolveUtil: resolveUtil)
        resolved.accept(visitor)
        resolvedType = visitor.resolvedType ?? element
    }

    override func visitArrayType(_ element: ArrayType) {
        let resolved = resolveType(element.elementType)
        if let r = resolved {
            resolvedType = ElementParser.parseType("[\(r.text)]")
        }
    }

    override func visitDictionaryType(_ element: DictionaryType) {
        let resolvedKeyType = resolveType(element.keyType)
        let resolvedValueType = resolveType(element.valueType)
        if resolvedKeyType == nil && resolvedValueType == nil {
            return
        }
        resolvedType = ElementParser.parseType("[\(resolvedKeyType?.text ?? element.keyType.text): \(resolvedValueType?.text ?? element.valueType.text)]")
    }

    override func visitOptionalType(_ element: OptionalType) {
        let resolved = resolveType(element.type)
        if let r = resolved {
            resolvedType = ElementParser.parseType("\(r.text)?")
        }
    }

    private func resolveType(_ element: Type) -> Type? {
        let visitor = TypeResolverVisitor(resolveUtil: resolveUtil)
        element.accept(visitor)
        return visitor.resolvedType
    }

    private class ResolvedVisitor: ElementVisitor {

        let resolveUtil: ResolveUtil
        var resolvedType: Type?

        init(resolveUtil: ResolveUtil) {
            self.resolveUtil = resolveUtil
        }

        override func visitTypealias(_ element: Typealias) {
            resolvedType = element.typealiasAssignment.type
            if let resolved = ResolveUtil().resolve(element.typealiasAssignment.type) {
                resolved.accept(self)
            }
        }
    }
}
