import AST
import ASTImpl
import Resolver

class VariableTypeResolver: RecursiveElementVisitor {
  public class func resolve(_ element: Element?, resolver: Resolver) -> String? {
    let visitor = VariableTypeResolver(resolver: resolver)
    element?.accept(visitor)
    return visitor.name
  }

  let resolver: Resolver
  var name: String?

  init(resolver: Resolver) {
    self.resolver = resolver
  }

  private func resolve(_ element: Element?) -> String? {
    return VariableTypeResolver.resolve(element, resolver: resolver)
  }

  override func visitVariableDeclaration(_ element: VariableDeclaration) {
    if let typeAnnotation = element.typeAnnotation {
      name = typeAnnotation.type.text
    } else {
      element.patternInitializerList.patternInitializers.first?.accept(self)
    }
  }

  override func visitStaticStringLiteralExpression(_ element: StaticStringLiteralExpression) {
    name = "String"
  }

  override func visitFloatingPointLiteralExpression(_ element: FloatingPointLiteralExpression) {
    name = "Double"
  }

  override func visitIntegerLiteralExpression(_ element: IntegerLiteralExpression) {
    name = "Int"
  }

  override func visitBooleanLiteralExpression(_ element: BooleanLiteralExpression) {
    name = "Bool"
  }

  override func visitArrayLiteralExpression(_ element: ArrayLiteralExpression) {
    guard let value = resolve(element.arrayLiteralItems?.items.first?.expression) else {
      name = nil
      return
    }
    name = "[\(value)]"
  }

  override func visitDictionaryLiteralExpression(_ element: DictionaryLiteralExpression) {
    guard let key = resolve(element.dictionaryLiteralItems?.items.first?.keyExpression),
          let value = resolve(element.dictionaryLiteralItems?.items.first?.valueExpression) else {
      name = nil
      return
    }
    name = "[\(key): \(value)]"
  }

  override func visitFunctionCallExpression(_ element: FunctionCallExpression) {
    name = resolve(element.postfixExpression)
  }

  override func visitExpression(_ element: Expression) {
    if let identifier = resolve(element.prefixExpression) {
      name = identifier
      return
    }
    super.visitExpression(element)
  }

  override func visitPrefixExpression(_ element: PrefixExpression) {
    name = element.text
    super.visitPrefixExpression(element)
  }

  override func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
    if let resolved = resolve(resolver.resolve(element)) {
      name = resolved
    }
  }
}
