import AST
import SwiftyKit
import UseCases

class VariableTypeResolver: RecursiveElementVisitor {

  public class func resolve(_ element: AST.Element?, resolver: Resolver) -> UseCases.`Type`? {
    let visitor = VariableTypeResolver(resolver: resolver)
    element?.accept(visitor)
    return visitor.type
  }

  let resolver: Resolver
  var type: UseCases.`Type`?

  init(resolver: Resolver) {
    self.resolver = resolver
  }

  private func resolve(_ element: AST.Element?) -> UseCases.`Type`? {
    return VariableTypeResolver.resolve(element, resolver: resolver)
  }

  override func visitVariableDeclaration(_ element: VariableDeclaration) {
    if let typeAnnotation = element.typeAnnotation {
      setTypeIdentifier(typeAnnotation.type.text)
    } else if let last = getLastBinaryExpression(element) {
      last.accept(self)
    } else {
      element.patternInitializerList.patternInitializers.first?.accept(self)
    }
  }

  private func getLastBinaryExpression(_ element: VariableDeclaration) -> BinaryExpression? {
    return element
      .patternInitializerList
      .patternInitializers
      .first?
      .initializer?
      .expression
      .binaryExpressions?
      .expressions
      .last
  }

  override func visitType(_ element: AST.`Type`) {
    transformType(element)
  }

  private func transformType(_ element: AST.Element?) {
    if let element = element {
      type = MemberTransformingVisitor.transformType(element, resolver: resolver)
    }
  }

  override func visitStaticStringLiteralExpression(_ element: StaticStringLiteralExpression) {
    setTypeIdentifier("String")
  }

  override func visitNumericLiteralExpression(_ element: NumericLiteralExpression) {
    if element.literal is FloatingPointLiteral {
      setTypeIdentifier("Double")
    } else if element.literal is IntegerLiteral {
      setTypeIdentifier("Int")
    }
  }

  override func visitBooleanLiteralExpression(_ element: BooleanLiteralExpression) {
    setTypeIdentifier("Bool")
  }

  override func visitArrayLiteralExpression(_ element: ArrayLiteralExpression) {
    guard let value = resolve(element.arrayLiteralItems?.items.first?.expression) else {
      type = nil
      return
    }
    type = ArrayType(type: value, useVerboseSyntax: false)
  }

  override func visitDictionaryLiteralExpression(_ element: DictionaryLiteralExpression) {
    guard let key = resolve(element.dictionaryLiteralItems?.items.first?.keyExpression),
          let value = resolve(element.dictionaryLiteralItems?.items.first?.valueExpression)
    else {
      type = nil
      return
    }
    type = DictionaryType(keyType: key, valueType: value, useVerboseSyntax: false)
  }

  override func visitFunctionCallExpression(_ element: FunctionCallExpression) {
    if let type = resolve(element.postfixExpression) {
      self.type = type
    }
  }

  override func visitExplicitMemberExpression(_ element: ExplicitMemberExpression) {
    if let identifier = element.identifier {
      type = resolve(resolver.resolve(identifier))
    }
  }

  override func visitExpression(_ element: Expression) {
    if let type = resolve(element.prefixExpression) {
      self.type = type
      return
    }
    super.visitExpression(element)
  }

  override func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
    if let resolved = resolve(resolver.resolve(element)) {
      type = resolved
    }
  }

  override func visitTupleExpression(_ element: TupleExpression) {
    let resolved = element.tupleElementList.elements.map {
      resolve($0) ?? UseCases.TypeIdentifier(identifier: "Any")
    }.map {
      TupleType.TupleElement(label: nil, type: $0)
    }
    type = TupleType(tupleElements: resolved)
  }

  override func visitClosureExpression(_ element: ClosureExpression) {
    // TODO: not supported
  }

  override func visitSubscriptExpression(_ element: SubscriptExpression) {
    // TODO: not supported
  }

  override func visitOperatorPostfixExpression(_ element: OperatorPostfixExpression) {
    // TODO: not supported
  }

  override func visitConditionalOperator(_ element: ConditionalOperator) {
    // TODO: not supported
  }

  override func visitBinaryExpression(_ element: BinaryExpression) {
    if element.children.contains(where: { $0 is Operator }) {
      // TODO: support operators
      return
    } else if element.children.contains(where: { $0 is ConditionalOperator }) {
      // TODO: support conditional operator
      return
    }
    super.visitBinaryExpression(element)
  }

  override func visitTypeDeclaration(_ element: AST.TypeDeclaration) {
    setTypeIdentifier(element.name)
  }

  override func visitTypeCastingOperator(_ element: TypeCastingOperator) {
    if element.isAs {
      super.visitTypeCastingOperator(element)
    } else {
      setTypeIdentifier("Bool")
    }
  }

  private func setTypeIdentifier(_ name: String?) {
    if let name = name {
      type = UseCases.TypeIdentifier(identifier: name)
    }
  }
}
