#import <Foundation/Foundation.h>

@class UseCasesSwiftStringConvenienceInitCall, UseCasesInitialiserCall, UseCasesDefaultValueStore, UseCasesSwiftStringInitialiserDeclaration, UseCasesSwiftStringProtocolInitialiserDeclaration, UseCasesInitializer, UseCasesSwiftStringTupleForwardCall, UseCasesTuplePropertyDeclaration, UseCasesArrayType, UseCasesVisitor, UseCasesArrayTypeBuilder, UseCasesTypeFactory, UseCasesClass, UseCasesTypeDeclaration, UseCasesProperty, UseCasesMethod, UseCasesSubscript, UseCasesProtocol, UseCasesClassBuilder, UseCasesStdlibUnit, UseCasesInitializerBuilder, UseCasesPropertyBuilder, UseCasesMethodBuilder, UseCasesSubscriptBuilder, UseCasesDictionaryType, UseCasesDictionaryTypeBuilder, UseCasesFunctionType, UseCasesFunctionTypeBuilder, UseCasesGenericType, UseCasesGenericTypeBuilder, UseCasesParameter, UseCasesParameterBuilder, UseCasesResolvedType, UseCasesMockClass, UseCasesMockClassBuilder, UseCasesProtocolBuilder, UseCasesOptionalType, UseCasesOptionalTypeBuilder, UseCasesPropertyDeclaration, UseCasesPropertyDeclarationCompanion, UseCasesResolvedTypeCompanion, UseCasesResolvedTypeBuilder, UseCasesTypeIdentifier, UseCasesTuplePropertyDeclarationTupleParameter, UseCasesTuplePropertyDeclarationCompanion, UseCasesTupleType, UseCasesTupleTypeTupleElement, UseCasesTupleTypeBuilder, UseCasesTypeIdentifierBuilder, UseCasesTypeIdentifierCompanion, UseCasesCallbackMockView, UseCasesMockViewModel, UseCasesGenerator, UseCasesStdlibArray, UseCasesInitializerViewModel, UseCasesPropertyViewModel, UseCasesMethodViewModel, UseCasesSubscriptViewModel, UseCasesParametersViewModel, UseCasesClosureParameterViewModel, UseCasesResultTypeViewModel, UseCasesMockViewPresenter, UseCasesAppendStringDecorator, UseCasesStringDecorator, UseCasesClosureUtil, UseCasesClosureUtilCompanion, UseCasesKeywordsStore, UseCasesMethodModel, UseCasesParameterUtil, UseCasesParameterUtilCompanion, UseCasesPrependStringDecorator, UseCasesUniqueMethodNameGenerator, UseCasesCreateConvenienceInitialiser, UseCasesCreateInvokedParameters, UseCasesCreateParameterTuple, UseCasesCopyVisitor, UseCasesCopyVisitorCompanion, UseCasesDefaultValueVisitor, UseCasesDefaultValueVisitorCompanion, UseCasesFunctionParameterTransformer, UseCasesRecursiveVisitor, UseCasesMakeFunctionCallVisitor, UseCasesMakeFunctionCallVisitorCompanion, UseCasesOptionalizeIUOVisitor, UseCasesOptionalizeIUOVisitorCompanion, UseCasesRecursiveRemoveOptionalVisitor, UseCasesRecursiveRemoveOptionalVisitorCompanion, UseCasesRemoveOptionalVisitor, UseCasesRemoveOptionalVisitorCompanion, UseCasesSignatureGenerator, UseCasesSignatureGeneratorCompanion, UseCasesSurroundOptionalVisitor, UseCasesSurroundOptionalVisitorCompanion, UseCasesTypeErasingVisitor, UseCasesTypeErasingVisitorCompanion;

@protocol UseCasesType, UseCasesElement, UseCasesMockView, UseCasesMockTransformer, UseCasesStdlibIterator;

NS_ASSUME_NONNULL_BEGIN

@interface KotlinBase : NSObject
- (instancetype)init __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
+ (void)initialize __attribute__((objc_requires_super));
@end;

@interface KotlinBase (KotlinBaseCopying) <NSCopying>
@end;

__attribute__((objc_runtime_name("KotlinMutableSet")))
@interface UseCasesMutableSet<ObjectType> : NSMutableSet<ObjectType>
@end;

__attribute__((objc_runtime_name("KotlinMutableDictionary")))
@interface UseCasesMutableDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>
@end;

@interface NSError (NSErrorKotlinException)
@property (readonly) id _Nullable kotlinException;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSwiftStringConvenienceInitCall : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformCall:(UseCasesInitialiserCall *)call __attribute__((swift_name("transform(call:)")));
@property (readonly) UseCasesDefaultValueStore *store;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSwiftStringInitialiserDeclaration : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformCall:(UseCasesInitialiserCall *)call __attribute__((swift_name("transform(call:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSwiftStringProtocolInitialiserDeclaration : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformInitializer:(UseCasesInitializer *)initializer __attribute__((swift_name("transform(initializer:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSwiftStringTupleForwardCall : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformProperty:(UseCasesTuplePropertyDeclaration *)property __attribute__((swift_name("transform(property:)")));
@end;

@protocol UseCasesElement
@required
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
@end;

@protocol UseCasesType <UseCasesElement>
@required
@property (readonly) NSString *text;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesArrayType : KotlinBase <UseCasesType>
- (instancetype)initWithType:(id<UseCasesType>)type useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(type:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (UseCasesArrayType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()")));
- (BOOL)component2 __attribute__((swift_name("component2()")));
- (UseCasesArrayType *)doCopyType:(id<UseCasesType>)type useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(type:useVerboseSyntax:)")));
@property (readonly) id<UseCasesType> type;
@property BOOL useVerboseSyntax;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesArrayTypeBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesArrayTypeBuilder *)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (UseCasesTypeFactory *)type __attribute__((swift_name("type()")));
- (UseCasesArrayTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesArrayType *)build __attribute__((swift_name("build()")));
@end;

@interface UseCasesTypeDeclaration : KotlinBase
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesInitializer *> *initializers;
@property (readonly) NSArray<UseCasesProperty *> *properties;
@property (readonly) NSArray<UseCasesMethod *> *methods;
@property (readonly) NSArray<UseCasesSubscript *> *subscripts;
@property (readonly) NSArray<UseCasesProtocol *> *protocols;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesClass : UseCasesTypeDeclaration
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts inheritedClass:(UseCasesClass * _Nullable)inheritedClass __attribute__((swift_name("init(initializers:properties:methods:subscripts:inheritedClass:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (readonly) UseCasesClass * _Nullable inheritedClass;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesClassBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesClassBuilder *)initializerBuild:(UseCasesStdlibUnit *(^)(UseCasesInitializerBuilder *))build __attribute__((swift_name("initializer(build:)")));
- (UseCasesClassBuilder *)propertyName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesPropertyBuilder *))build __attribute__((swift_name("property(name:build:)")));
- (UseCasesClassBuilder *)methodName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesMethodBuilder *))build __attribute__((swift_name("method(name:build:)")));
- (UseCasesClassBuilder *)subscriptReturnType:(id<UseCasesType>)returnType build:(UseCasesStdlibUnit *(^)(UseCasesSubscriptBuilder *))build __attribute__((swift_name("subscript(returnType:build:)")));
- (UseCasesClassBuilder *)superclassBuild:(UseCasesStdlibUnit *(^)(UseCasesClassBuilder *))build __attribute__((swift_name("superclass(build:)")));
- (UseCasesClass *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesDictionaryType : KotlinBase <UseCasesType>
- (instancetype)initWithKeyType:(id<UseCasesType>)keyType valueType:(id<UseCasesType>)valueType useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(keyType:valueType:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (UseCasesDictionaryType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()")));
- (UseCasesDictionaryType *)doCopyKeyType:(id<UseCasesType>)keyType valueType:(id<UseCasesType>)valueType useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(keyType:valueType:useVerboseSyntax:)")));
@property id<UseCasesType> keyType;
@property (readonly) id<UseCasesType> valueType;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesDictionaryTypeBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesDictionaryTypeBuilder *)keyTypeType:(NSString *)type __attribute__((swift_name("keyType(type:)")));
- (UseCasesTypeFactory *)keyType __attribute__((swift_name("keyType()")));
- (UseCasesDictionaryTypeBuilder *)valueTypeType:(NSString *)type __attribute__((swift_name("valueType(type:)")));
- (UseCasesTypeFactory *)valueType __attribute__((swift_name("valueType()")));
- (UseCasesDictionaryTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesDictionaryType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesFunctionType : KotlinBase <UseCasesType>
- (instancetype)initWithArguments:(NSArray<id<UseCasesType>> *)arguments returnType:(id<UseCasesType>)returnType throws:(BOOL)throws __attribute__((swift_name("init(arguments:returnType:throws:)"))) __attribute__((objc_designated_initializer));
- (UseCasesFunctionType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (NSArray<id<UseCasesType>> *)component1 __attribute__((swift_name("component1()")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()")));
- (BOOL)component3 __attribute__((swift_name("component3()")));
- (UseCasesFunctionType *)doCopyArguments:(NSArray<id<UseCasesType>> *)arguments returnType:(id<UseCasesType>)returnType throws:(BOOL)throws __attribute__((swift_name("doCopy(arguments:returnType:throws:)")));
@property (readonly) NSArray<id<UseCasesType>> *arguments;
@property (readonly) id<UseCasesType> returnType;
@property (readonly) BOOL throws;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesFunctionTypeBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesFunctionTypeBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesFunctionTypeBuilder *)argumentType:(NSString *)type __attribute__((swift_name("argument(type:)")));
- (UseCasesTypeFactory *)argument __attribute__((swift_name("argument()")));
- (UseCasesFunctionTypeBuilder *)returnTypeType:(NSString *)type __attribute__((swift_name("returnType(type:)")));
- (UseCasesTypeFactory *)returnType __attribute__((swift_name("returnType()")));
- (UseCasesFunctionType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesGenericType : KotlinBase <UseCasesType>
- (instancetype)initWithIdentifier:(NSString *)identifier arguments:(NSArray<id<UseCasesType>> *)arguments __attribute__((swift_name("init(identifier:arguments:)"))) __attribute__((objc_designated_initializer));
- (UseCasesGenericType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSArray<id<UseCasesType>> *)component2 __attribute__((swift_name("component2()")));
- (UseCasesGenericType *)doCopyIdentifier:(NSString *)identifier arguments:(NSArray<id<UseCasesType>> *)arguments __attribute__((swift_name("doCopy(identifier:arguments:)")));
@property (readonly) NSString *identifier;
@property (readonly) NSArray<id<UseCasesType>> *arguments;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesGenericTypeBuilder : KotlinBase
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (UseCasesGenericTypeBuilder *)argumentIdentifier:(NSString *)identifier __attribute__((swift_name("argument(identifier:)")));
- (UseCasesTypeFactory *)argument __attribute__((swift_name("argument()")));
- (UseCasesGenericType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesInitialiserCall : KotlinBase
- (instancetype)initWithParameters:(NSArray<UseCasesParameter *> *)parameters isFailable:(BOOL)isFailable __attribute__((swift_name("init(parameters:isFailable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithParameters:(NSArray<UseCasesParameter *> *)parameters isFailable:(BOOL)isFailable throws:(BOOL)throws __attribute__((swift_name("init(parameters:isFailable:throws:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesParameter *> *parameters;
@property (readonly) BOOL isFailable;
@property (readonly) BOOL throws;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesInitializer : KotlinBase <UseCasesElement>
- (instancetype)initWithParametersList:(NSArray<UseCasesParameter *> *)parametersList isFailable:(BOOL)isFailable throws:(BOOL)throws __attribute__((swift_name("init(parametersList:isFailable:throws:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesParameter *> *parametersList;
@property (readonly) BOOL isFailable;
@property (readonly) BOOL throws;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesInitializerBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesInitializerBuilder *)failable __attribute__((swift_name("failable()")));
- (UseCasesInitializerBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesInitializerBuilder *)parameterName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesInitializerBuilder *)parameterExternalName:(NSString *)externalName internalName:(NSString *)internalName build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesInitializer *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMethod : KotlinBase <UseCasesElement>
- (instancetype)initWithName:(NSString *)name genericParameters:(NSArray<NSString *> *)genericParameters returnType:(UseCasesResolvedType *)returnType parametersList:(NSArray<UseCasesParameter *> *)parametersList declarationText:(NSString *)declarationText throws:(BOOL)throws rethrows:(BOOL)rethrows __attribute__((swift_name("init(name:genericParameters:returnType:parametersList:declarationText:throws:rethrows:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSArray<NSString *> *)component2 __attribute__((swift_name("component2()")));
- (UseCasesResolvedType *)component3 __attribute__((swift_name("component3()")));
- (NSArray<UseCasesParameter *> *)component4 __attribute__((swift_name("component4()")));
- (NSString *)component5 __attribute__((swift_name("component5()")));
- (BOOL)component6 __attribute__((swift_name("component6()")));
- (BOOL)component7 __attribute__((swift_name("component7()")));
- (UseCasesMethod *)doCopyName:(NSString *)name genericParameters:(NSArray<NSString *> *)genericParameters returnType:(UseCasesResolvedType *)returnType parametersList:(NSArray<UseCasesParameter *> *)parametersList declarationText:(NSString *)declarationText throws:(BOOL)throws rethrows:(BOOL)rethrows __attribute__((swift_name("doCopy(name:genericParameters:returnType:parametersList:declarationText:throws:rethrows:)")));
@property (readonly) NSString *name;
@property (readonly) NSArray<NSString *> *genericParameters;
@property (readonly) UseCasesResolvedType *returnType;
@property (readonly) NSArray<UseCasesParameter *> *parametersList;
@property (readonly) NSString *declarationText;
@property (readonly) BOOL throws;
@property (readonly) BOOL rethrows;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMethodBuilder : KotlinBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (UseCasesMethod *)build __attribute__((swift_name("build()")));
- (UseCasesMethodBuilder *)returnTypeType:(NSString *)type __attribute__((swift_name("returnType(type:)")));
- (UseCasesTypeFactory *)returnType __attribute__((swift_name("returnType()")));
- (UseCasesMethodBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesMethodBuilder *)rethrows __attribute__((swift_name("rethrows()")));
- (UseCasesMethodBuilder *)parameterName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesMethodBuilder *)parameterExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesMethodBuilder *)genericParameterIdentifier:(NSString *)identifier __attribute__((swift_name("genericParameter(identifier:)")));
@property (readonly) NSString *name;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMockClass : UseCasesTypeDeclaration
- (instancetype)initWithInheritedClass:(UseCasesClass * _Nullable)inheritedClass protocols:(NSArray<UseCasesProtocol *> *)protocols scope:(NSString * _Nullable)scope __attribute__((swift_name("init(inheritedClass:protocols:scope:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (readonly) UseCasesClass * _Nullable inheritedClass;
@property (readonly) NSString * _Nullable scope;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMockClassBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesMockClassBuilder *)superclassBuild:(UseCasesStdlibUnit *(^)(UseCasesClassBuilder *))build __attribute__((swift_name("superclass(build:)")));
- (UseCasesMockClassBuilder *)protocolBuild:(UseCasesStdlibUnit *(^)(UseCasesProtocolBuilder *))build __attribute__((swift_name("protocol(build:)")));
- (UseCasesMockClassBuilder *)scopeScope:(NSString *)scope __attribute__((swift_name("scope(scope:)")));
- (UseCasesMockClass *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesOptionalType : KotlinBase <UseCasesType>
- (instancetype)initWithType:(id<UseCasesType>)type isImplicitlyUnwrapped:(BOOL)isImplicitlyUnwrapped useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(type:isImplicitlyUnwrapped:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (UseCasesOptionalType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()")));
- (BOOL)component2 __attribute__((swift_name("component2()")));
- (BOOL)component3 __attribute__((swift_name("component3()")));
- (UseCasesOptionalType *)doCopyType:(id<UseCasesType>)type isImplicitlyUnwrapped:(BOOL)isImplicitlyUnwrapped useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(type:isImplicitlyUnwrapped:useVerboseSyntax:)")));
@property (readonly) id<UseCasesType> type;
@property (readonly) BOOL isImplicitlyUnwrapped;
@property (readonly) BOOL useVerboseSyntax;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesOptionalTypeBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesOptionalTypeBuilder *)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (UseCasesOptionalTypeBuilder *)typeType_:(id<UseCasesType>)type __attribute__((swift_name("type(type_:)")));
- (UseCasesTypeFactory *)type __attribute__((swift_name("type()")));
- (UseCasesOptionalTypeBuilder *)unwrapped __attribute__((swift_name("unwrapped()")));
- (UseCasesOptionalTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesOptionalType *)build __attribute__((swift_name("build()")));
@end;

@interface UseCasesParameter : KotlinBase <UseCasesElement>
- (instancetype)initWithExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName type:(UseCasesResolvedType *)type text:(NSString *)text isEscaping:(BOOL)isEscaping __attribute__((swift_name("init(externalName:internalName:type:text:isEscaping:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *originalTypeText;
@property (readonly) NSString *resolvedTypeText;
@property (readonly) NSString * _Nullable externalName;
@property (readonly) NSString *internalName;
@property (readonly) UseCasesResolvedType *type;
@property (readonly) NSString *text;
@property (readonly) BOOL isEscaping;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesParameterBuilder : KotlinBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName __attribute__((swift_name("init(externalName:internalName:)"))) __attribute__((objc_designated_initializer));
- (UseCasesParameterBuilder *)typeString:(NSString *)string __attribute__((swift_name("type(string:)")));
- (UseCasesTypeFactory *)type __attribute__((swift_name("type()")));
- (UseCasesTypeFactory *)resolvedType __attribute__((swift_name("resolvedType()")));
- (UseCasesParameterBuilder *)escaping __attribute__((swift_name("escaping()")));
- (UseCasesParameterBuilder *)annotationAnnotation:(NSString *)annotation __attribute__((swift_name("annotation(annotation:)")));
- (UseCasesParameterBuilder *)inout __attribute__((swift_name("inout()")));
- (UseCasesParameter *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesProperty : KotlinBase <UseCasesElement>
- (instancetype)initWithName:(NSString *)name type:(id<UseCasesType>)type isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("init(name:type:isWritable:declarationText:)"))) __attribute__((objc_designated_initializer));
- (NSString *)getTrimmedDeclarationText __attribute__((swift_name("getTrimmedDeclarationText()")));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()")));
- (BOOL)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (UseCasesProperty *)doCopyName:(NSString *)name type:(id<UseCasesType>)type isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("doCopy(name:type:isWritable:declarationText:)")));
@property (readonly) NSString *name;
@property (readonly) id<UseCasesType> type;
@property (readonly) BOOL isWritable;
@property (readonly) NSString *declarationText;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesPropertyBuilder : KotlinBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (UseCasesPropertyBuilder *)readonly __attribute__((swift_name("readonly()")));
- (UseCasesPropertyBuilder *)typeIdentifier:(NSString *)identifier __attribute__((swift_name("type(identifier:)")));
- (UseCasesTypeFactory *)type __attribute__((swift_name("type()")));
- (UseCasesProperty *)build __attribute__((swift_name("build()")));
@end;

@interface UseCasesPropertyDeclaration : KotlinBase
- (instancetype)initWithName:(NSString *)name type:(NSString *)type __attribute__((swift_name("init(name:type:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *name;
@property (readonly) NSString *type;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesPropertyDeclarationCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (readonly) UseCasesPropertyDeclaration *EMPTY;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesProtocol : UseCasesTypeDeclaration
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesProtocolBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesProtocolBuilder *)initializerBuild:(UseCasesStdlibUnit *(^)(UseCasesInitializerBuilder *))build __attribute__((swift_name("initializer(build:)")));
- (UseCasesProtocolBuilder *)propertyName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesPropertyBuilder *))build __attribute__((swift_name("property(name:build:)")));
- (UseCasesProtocolBuilder *)methodName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesMethodBuilder *))build __attribute__((swift_name("method(name:build:)")));
- (UseCasesProtocolBuilder *)subscriptType:(id<UseCasesType>)type build:(UseCasesStdlibUnit *(^)(UseCasesSubscriptBuilder *))build __attribute__((swift_name("subscript(type:build:)")));
- (UseCasesProtocolBuilder *)protocolBuild:(UseCasesStdlibUnit *(^)(UseCasesProtocolBuilder *))build __attribute__((swift_name("protocol(build:)")));
- (UseCasesProtocol *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesResolvedType : KotlinBase
- (instancetype)initWithOriginalType:(id<UseCasesType>)originalType resolvedType:(id<UseCasesType>)resolvedType __attribute__((swift_name("init(originalType:resolvedType:)"))) __attribute__((objc_designated_initializer));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()")));
- (UseCasesResolvedType *)doCopyOriginalType:(id<UseCasesType>)originalType resolvedType:(id<UseCasesType>)resolvedType __attribute__((swift_name("doCopy(originalType:resolvedType:)")));
@property id<UseCasesType> originalType;
@property id<UseCasesType> resolvedType;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesResolvedTypeCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (readonly) UseCasesResolvedType *IMPLICIT;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesResolvedTypeBuilder : KotlinBase
- (instancetype)initWithType:(NSString *)type __attribute__((swift_name("init(type:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithOriginalType:(UseCasesTypeIdentifier *)originalType resolvedType:(UseCasesTypeIdentifier *)resolvedType __attribute__((swift_name("init(originalType:resolvedType:)"))) __attribute__((objc_designated_initializer));
- (UseCasesResolvedType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSubscript : KotlinBase <UseCasesElement>
- (instancetype)initWithReturnType:(UseCasesResolvedType *)returnType parameters:(NSArray<UseCasesParameter *> *)parameters isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("init(returnType:parameters:isWritable:declarationText:)"))) __attribute__((objc_designated_initializer));
@property (readonly) UseCasesResolvedType *returnType;
@property (readonly) NSArray<UseCasesParameter *> *parameters;
@property (readonly) BOOL isWritable;
@property (readonly) NSString *declarationText;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSubscriptBuilder : KotlinBase
- (instancetype)initWithReturnType:(id<UseCasesType>)returnType __attribute__((swift_name("init(returnType:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithReturnType_:(UseCasesResolvedType *)returnType __attribute__((swift_name("init(returnType_:)"))) __attribute__((objc_designated_initializer));
- (UseCasesSubscriptBuilder *)parameterName:(NSString *)name build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesSubscriptBuilder *)parameterExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName build:(UseCasesStdlibUnit *(^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesSubscriptBuilder *)readonly __attribute__((swift_name("readonly()")));
- (UseCasesSubscript *)build __attribute__((swift_name("build()")));
@property (readonly) UseCasesResolvedType *returnType;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTuplePropertyDeclaration : KotlinBase
- (instancetype)initWithParameters:(NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *)parameters __attribute__((swift_name("init(parameters:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithParameters:(NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *)parameters text:(NSString *)text __attribute__((swift_name("init(parameters:text:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *parameters;
@property (readonly) NSString *text;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTuplePropertyDeclarationTupleParameter : KotlinBase
- (instancetype)initWithName:(NSString *)name type:(NSString *)type __attribute__((swift_name("init(name:type:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithName:(NSString *)name type:(NSString *)type resolvedType:(NSString *)resolvedType __attribute__((swift_name("init(name:type:resolvedType:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *name;
@property (readonly) NSString *type;
@property (readonly) NSString *resolvedType;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTuplePropertyDeclarationCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTupleType : KotlinBase <UseCasesType>
- (instancetype)initWithTupleElements:(NSArray<UseCasesTupleTypeTupleElement *> *)tupleElements __attribute__((swift_name("init(tupleElements:)"))) __attribute__((objc_designated_initializer));
- (UseCasesTupleType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (NSArray<UseCasesTupleTypeTupleElement *> *)component1 __attribute__((swift_name("component1()")));
- (UseCasesTupleType *)doCopyTupleElements:(NSArray<UseCasesTupleTypeTupleElement *> *)tupleElements __attribute__((swift_name("doCopy(tupleElements:)")));
@property (readonly) NSArray<id> *labels;
@property (readonly) NSArray<id<UseCasesType>> *types;
@property (readonly) NSArray<UseCasesTupleTypeTupleElement *> *tupleElements;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTupleTypeTupleElement : KotlinBase
- (instancetype)initWithLabel:(NSString * _Nullable)label type:(id<UseCasesType>)type __attribute__((swift_name("init(label:type:)"))) __attribute__((objc_designated_initializer));
- (UseCasesTupleTypeTupleElement *)deepCopy __attribute__((swift_name("deepCopy()")));
- (NSString * _Nullable)component1 __attribute__((swift_name("component1()")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()")));
- (UseCasesTupleTypeTupleElement *)doCopyLabel:(NSString * _Nullable)label type:(id<UseCasesType>)type __attribute__((swift_name("doCopy(label:type:)")));
@property (readonly) NSString *text;
@property (readonly) NSString * _Nullable label;
@property (readonly) id<UseCasesType> type;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTupleTypeBuilder : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesTupleTypeBuilder *)elementIdentifier:(NSString *)identifier __attribute__((swift_name("element(identifier:)")));
- (UseCasesTupleTypeBuilder *)elementType:(id<UseCasesType>)type __attribute__((swift_name("element(type:)")));
- (UseCasesTypeFactory *)element __attribute__((swift_name("element()")));
- (UseCasesTupleTypeBuilder *)labelledElementLabel:(NSString * _Nullable)label identifier:(NSString *)identifier __attribute__((swift_name("labelledElement(label:identifier:)")));
- (UseCasesTypeFactory *)labelledElementLabel:(NSString * _Nullable)label __attribute__((swift_name("labelledElement(label:)")));
- (UseCasesTupleType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeFactory : KotlinBase
- (instancetype)initWithPreviousBuilder:(id _Nullable)previousBuilder getType:(UseCasesStdlibUnit *(^)(id<UseCasesType>))getType __attribute__((swift_name("init(previousBuilder:getType:)"))) __attribute__((objc_designated_initializer));
- (id _Nullable)functionBuild:(UseCasesStdlibUnit *(^)(UseCasesFunctionTypeBuilder *))build __attribute__((swift_name("function(build:)")));
- (id _Nullable)optionalBuild:(UseCasesStdlibUnit *(^)(UseCasesOptionalTypeBuilder *))build __attribute__((swift_name("optional(build:)")));
- (id _Nullable)arrayBuild:(UseCasesStdlibUnit *(^)(UseCasesArrayTypeBuilder *))build __attribute__((swift_name("array(build:)")));
- (id _Nullable)dictionaryBuild:(UseCasesStdlibUnit *(^)(UseCasesDictionaryTypeBuilder *))build __attribute__((swift_name("dictionary(build:)")));
- (id _Nullable)genericIdentifier:(NSString *)identifier build:(UseCasesStdlibUnit *(^)(UseCasesGenericTypeBuilder *))build __attribute__((swift_name("generic(identifier:build:)")));
- (UseCasesTypeFactory *)bracket __attribute__((swift_name("bracket()")));
- (id _Nullable)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (id _Nullable)typeIdentifierIdentifier:(NSString *)identifier build:(UseCasesStdlibUnit *(^)(UseCasesTypeIdentifierBuilder *))build __attribute__((swift_name("typeIdentifier(identifier:build:)")));
- (id _Nullable)tupleBuild:(UseCasesStdlibUnit *(^)(UseCasesTupleTypeBuilder *))build __attribute__((swift_name("tuple(build:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeIdentifier : KotlinBase <UseCasesType>
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithIdentifiers:(NSMutableArray<NSString *> *)identifiers __attribute__((swift_name("init(identifiers:)"))) __attribute__((objc_designated_initializer));
- (NSMutableArray<NSString *> *)component1 __attribute__((swift_name("component1()")));
- (UseCasesTypeIdentifier *)doCopyIdentifiers:(NSMutableArray<NSString *> *)identifiers __attribute__((swift_name("doCopy(identifiers:)")));
@property (readonly) BOOL isEmpty;
@property (readonly) NSString *firstIdentifier;
@property NSMutableArray<NSString *> *identifiers;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeIdentifierCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (BOOL)isVoidType:(id<UseCasesType>)type __attribute__((swift_name("isVoid(type:)")));
- (BOOL)isEmptyType:(id<UseCasesType>)type __attribute__((swift_name("isEmpty(type:)")));
@property (readonly) UseCasesTypeIdentifier *VOID;
@property (readonly) UseCasesTupleType *EMPTY_TUPLE;
@property (readonly) UseCasesTupleType *VOID_TUPLE;
@property (readonly) UseCasesTypeIdentifier *EMPTY;
@property (readonly) UseCasesTypeIdentifier *INT;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeIdentifierBuilder : KotlinBase
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (UseCasesTypeIdentifierBuilder *)nestIdentifier:(NSString *)identifier __attribute__((swift_name("nest(identifier:)")));
- (UseCasesTypeIdentifier *)build __attribute__((swift_name("build()")));
@end;

@protocol UseCasesMockView
@required
- (void)renderModel:(UseCasesMockViewModel *)model __attribute__((swift_name("render(model:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesCallbackMockView : KotlinBase <UseCasesMockView>
- (instancetype)initWithCallback:(NSString *(^)(UseCasesMockViewModel *))callback __attribute__((swift_name("init(callback:)"))) __attribute__((objc_designated_initializer));
@property NSArray<NSString *> *result;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesGenerator : KotlinBase
- (instancetype)initWithView:(id<UseCasesMockView>)view __attribute__((swift_name("init(view:)"))) __attribute__((objc_designated_initializer));
- (void)setC:(UseCasesMockClass *)c __attribute__((swift_name("set(c:)")));
- (NSString *)generate __attribute__((swift_name("generate()")));
@end;

@protocol UseCasesMockTransformer
@required
- (void)setScopeScope:(NSString *)scope __attribute__((swift_name("setScope(scope:)")));
- (void)addMethod:(UseCasesMethod *)method __attribute__((swift_name("add(method:)")));
- (void)addProperty:(UseCasesProperty *)property __attribute__((swift_name("add(property:)")));
- (void)addSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("add(subscript:)")));
- (void)addInitializers:(UseCasesStdlibArray *)initializers __attribute__((swift_name("add(initializers:)")));
- (void)addMethods:(UseCasesStdlibArray *)methods __attribute__((swift_name("add(methods:)")));
- (void)addProperties:(UseCasesStdlibArray *)properties __attribute__((swift_name("add(properties:)")));
- (void)addSubscripts:(UseCasesStdlibArray *)subscripts __attribute__((swift_name("add(subscripts:)")));
- (void)addInitialisersInitializers:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("addInitialisers(initializers:)")));
- (void)addMethodsMethods:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addMethods(methods:)")));
- (void)addPropertiesProperties:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addProperties(properties:)")));
- (void)addSubscriptsSubscripts:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addSubscripts(subscripts:)")));
- (void)setClassInitialisersInitializers:(UseCasesStdlibArray *)initializers __attribute__((swift_name("setClassInitialisers(initializers:)")));
- (void)setClassInitialisersInitializers_:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("setClassInitialisers(initializers_:)")));
- (void)addClassMethodsMethods:(UseCasesStdlibArray *)methods __attribute__((swift_name("addClassMethods(methods:)")));
- (void)addClassMethodsMethods_:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addClassMethods(methods_:)")));
- (void)addClassPropertiesProperties:(UseCasesStdlibArray *)properties __attribute__((swift_name("addClassProperties(properties:)")));
- (void)addClassPropertiesProperties_:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addClassProperties(properties_:)")));
- (void)addClassSubscriptsSubscripts:(UseCasesStdlibArray *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts:)")));
- (void)addClassSubscriptsSubscripts_:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts_:)")));
- (NSString *)generate __attribute__((swift_name("generate()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMockViewModel : KotlinBase
- (instancetype)initWithInitializer:(NSArray<UseCasesInitializerViewModel *> *)initializer property:(NSArray<UseCasesPropertyViewModel *> *)property method:(NSArray<UseCasesMethodViewModel *> *)method subscript:(NSArray<UseCasesSubscriptViewModel *> *)subscript scope:(NSString * _Nullable)scope __attribute__((swift_name("init(initializer:property:method:subscript:scope:)"))) __attribute__((objc_designated_initializer));
@property NSArray<UseCasesInitializerViewModel *> *initializer;
@property NSArray<UseCasesPropertyViewModel *> *property;
@property NSArray<UseCasesMethodViewModel *> *method;
@property NSArray<UseCasesSubscriptViewModel *> *subscript;
@property NSString * _Nullable scope;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesPropertyViewModel : KotlinBase
- (instancetype)initWithName:(NSString *)name capitalizedUniqueName:(NSString *)capitalizedUniqueName hasSetter:(BOOL)hasSetter type:(NSString *)type optionalType:(NSString *)optionalType iuoType:(NSString *)iuoType defaultValueAssignment:(NSString *)defaultValueAssignment defaultValue:(NSString * _Nullable)defaultValue isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(name:capitalizedUniqueName:hasSetter:type:optionalType:iuoType:defaultValueAssignment:defaultValue:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *name;
@property NSString *capitalizedUniqueName;
@property BOOL hasSetter;
@property NSString *type;
@property NSString *optionalType;
@property NSString *iuoType;
@property NSString *defaultValueAssignment;
@property NSString * _Nullable defaultValue;
@property BOOL isImplemented;
@property NSString *declarationText;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMethodViewModel : KotlinBase
- (instancetype)initWithCapitalizedUniqueName:(NSString *)capitalizedUniqueName escapingParameters:(UseCasesParametersViewModel * _Nullable)escapingParameters closureParameter:(NSArray<UseCasesClosureParameterViewModel *> *)closureParameter resultType:(UseCasesResultTypeViewModel * _Nullable)resultType functionCall:(NSString * _Nullable)functionCall throws:(BOOL)throws rethrows:(BOOL)rethrows isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(capitalizedUniqueName:escapingParameters:closureParameter:resultType:functionCall:throws:rethrows:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedUniqueName;
@property UseCasesParametersViewModel * _Nullable escapingParameters;
@property NSArray<UseCasesClosureParameterViewModel *> *closureParameter;
@property UseCasesResultTypeViewModel * _Nullable resultType;
@property NSString * _Nullable functionCall;
@property BOOL throws;
@property BOOL rethrows;
@property BOOL isImplemented;
@property NSString *declarationText;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesResultTypeViewModel : KotlinBase
- (instancetype)initWithDefaultValueAssignment:(NSString *)defaultValueAssignment defaultValue:(NSString * _Nullable)defaultValue optionalType:(NSString *)optionalType iuoType:(NSString *)iuoType type:(NSString *)type returnCastStatement:(NSString *)returnCastStatement __attribute__((swift_name("init(defaultValueAssignment:defaultValue:optionalType:iuoType:type:returnCastStatement:)"))) __attribute__((objc_designated_initializer));
@property NSString *defaultValueAssignment;
@property NSString * _Nullable defaultValue;
@property NSString *optionalType;
@property NSString *iuoType;
@property NSString *type;
@property NSString *returnCastStatement;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesParametersViewModel : KotlinBase
- (instancetype)initWithTupleRepresentation:(NSString *)tupleRepresentation tupleAssignment:(NSString *)tupleAssignment __attribute__((swift_name("init(tupleRepresentation:tupleAssignment:)"))) __attribute__((objc_designated_initializer));
@property NSString *tupleRepresentation;
@property NSString *tupleAssignment;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesClosureParameterViewModel : KotlinBase
- (instancetype)initWithCapitalizedName:(NSString *)capitalizedName name:(NSString *)name argumentsTupleRepresentation:(NSString *)argumentsTupleRepresentation implicitClosureCall:(NSString *)implicitClosureCall hasArguments:(BOOL)hasArguments __attribute__((swift_name("init(capitalizedName:name:argumentsTupleRepresentation:implicitClosureCall:hasArguments:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedName;
@property NSString *name;
@property NSString *argumentsTupleRepresentation;
@property NSString *implicitClosureCall;
@property BOOL hasArguments;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesInitializerViewModel : KotlinBase
- (instancetype)initWithDeclarationText:(NSString *)declarationText initializerCall:(NSString *)initializerCall __attribute__((swift_name("init(declarationText:initializerCall:)"))) __attribute__((objc_designated_initializer));
@property NSString *declarationText;
@property NSString *initializerCall;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSubscriptViewModel : KotlinBase
- (instancetype)initWithCapitalizedUniqueName:(NSString *)capitalizedUniqueName escapingParameters:(UseCasesParametersViewModel * _Nullable)escapingParameters hasSetter:(BOOL)hasSetter resultType:(UseCasesResultTypeViewModel *)resultType functionCall:(NSString * _Nullable)functionCall isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(capitalizedUniqueName:escapingParameters:hasSetter:resultType:functionCall:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedUniqueName;
@property UseCasesParametersViewModel * _Nullable escapingParameters;
@property BOOL hasSetter;
@property UseCasesResultTypeViewModel *resultType;
@property NSString * _Nullable functionCall;
@property BOOL isImplemented;
@property NSString *declarationText;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMockViewPresenter : KotlinBase <UseCasesMockTransformer>
- (instancetype)initWithView:(id<UseCasesMockView>)view __attribute__((swift_name("init(view:)"))) __attribute__((objc_designated_initializer));
@property (readonly) id<UseCasesMockView> view;
@end;

@interface UseCasesStringDecorator : KotlinBase
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer));
- (NSString *)processString:(NSString *)string __attribute__((swift_name("process(string:)")));
- (NSString *)decorateString:(NSString *)string __attribute__((swift_name("decorate(string:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesAppendStringDecorator : UseCasesStringDecorator
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator suffix:(NSString *)suffix __attribute__((swift_name("init(decorator:suffix:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesClosureUtil : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesClosureUtilCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (BOOL)isClosureType:(NSString *)type __attribute__((swift_name("isClosure(type:)")));
- (NSString *)surroundClosureType:(NSString *)type __attribute__((swift_name("surroundClosure(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesDefaultValueStore : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString * _Nullable)getDefaultValueTypeName:(NSString *)typeName __attribute__((swift_name("getDefaultValue(typeName:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesKeywordsStore : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (BOOL)isSwiftKeywordInput:(NSString *)input __attribute__((swift_name("isSwiftKeyword(input:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMethodModel : KotlinBase
- (instancetype)initWithMethodName:(NSString *)methodName paramLabels:(UseCasesStdlibArray *)paramLabels __attribute__((swift_name("init(methodName:paramLabels:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMethodName:(NSString *)methodName paramLabels_:(NSArray<UseCasesParameter *> *)paramLabels __attribute__((swift_name("init(methodName:paramLabels_:)"))) __attribute__((objc_designated_initializer));
- (NSString * _Nullable)nextPreferredName __attribute__((swift_name("nextPreferredName()")));
- (NSString * _Nullable)peekNextPreferredName __attribute__((swift_name("peekNextPreferredName()")));
@property (readonly) NSString *id;
@property (readonly) int32_t parameterCount;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesParameterUtil : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesParameterUtilCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (NSArray<NSString *> *)getParameterListParameters:(NSString *)parameters __attribute__((swift_name("getParameterList(parameters:)")));
- (NSArray<UseCasesParameter *> *)getParametersParameters:(NSString *)parameters __attribute__((swift_name("getParameters(parameters:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesPrependStringDecorator : UseCasesStringDecorator
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator prefix:(NSString *)prefix __attribute__((swift_name("init(decorator:prefix:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesUniqueMethodNameGenerator : KotlinBase
- (instancetype)initWithMethodModels:(UseCasesStdlibArray *)methodModels __attribute__((swift_name("init(methodModels:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMethodModels_:(NSArray<UseCasesMethodModel *> *)methodModels __attribute__((swift_name("init(methodModels_:)"))) __attribute__((objc_designated_initializer));
- (void)generateMethodNames __attribute__((swift_name("generateMethodNames()")));
- (NSString * _Nullable)getMethodNameId:(NSString *)id __attribute__((swift_name("getMethodName(id:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesCreateConvenienceInitialiser : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesInitialiserCall * _Nullable)transformInitializer:(UseCasesInitializer *)initializer __attribute__((swift_name("transform(initializer:)")));
@end;

@interface UseCasesCreateParameterTuple : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesStringDecorator *)getStringDecorator __attribute__((swift_name("getStringDecorator()")));
- (UseCasesTuplePropertyDeclaration * _Nullable)transformParameterList:(NSArray<UseCasesParameter *> *)parameterList genericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("transform(parameterList:genericIdentifiers:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesCreateInvokedParameters : UseCasesCreateParameterTuple
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

@interface UseCasesVisitor : KotlinBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)visitTypeType:(id<UseCasesType>)type __attribute__((swift_name("visitType(type:)")));
- (void)visitTypeIdentifierType:(UseCasesTypeIdentifier *)type __attribute__((swift_name("visitTypeIdentifier(type:)")));
- (void)visitFunctionTypeType:(UseCasesFunctionType *)type __attribute__((swift_name("visitFunctionType(type:)")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
- (void)visitTupleTypeType:(UseCasesTupleType *)type __attribute__((swift_name("visitTupleType(type:)")));
- (void)visitArrayTypeType:(UseCasesArrayType *)type __attribute__((swift_name("visitArrayType(type:)")));
- (void)visitDictionaryTypeType:(UseCasesDictionaryType *)type __attribute__((swift_name("visitDictionaryType(type:)")));
- (void)visitGenericTypeType:(UseCasesGenericType *)type __attribute__((swift_name("visitGenericType(type:)")));
- (void)visitMethodDeclaration:(UseCasesMethod *)declaration __attribute__((swift_name("visitMethod(declaration:)")));
- (void)visitPropertyDeclaration:(UseCasesProperty *)declaration __attribute__((swift_name("visitProperty(declaration:)")));
- (void)visitInitializerDeclaration:(UseCasesInitializer *)declaration __attribute__((swift_name("visitInitializer(declaration:)")));
- (void)visitParameterParameter:(UseCasesParameter *)parameter __attribute__((swift_name("visitParameter(parameter:)")));
- (void)visitSubscriptSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("visitSubscript(subscript:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesCopyVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (getter=doCopy) id<UseCasesType> copy;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesCopyVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<UseCasesType>)doCopyType:(id<UseCasesType>)type __attribute__((swift_name("doCopy(type:)")));
- (NSArray<id<UseCasesType>> *)doCopyTypes:(NSArray<id<UseCasesType>> *)types __attribute__((swift_name("doCopy(types:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesDefaultValueVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property NSString * _Nullable defaultValue;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesDefaultValueVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (NSString * _Nullable)getDefaultValueElement:(id<UseCasesElement>)element __attribute__((swift_name("getDefaultValue(element:)")));
@end;

@interface UseCasesRecursiveVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesFunctionParameterTransformer : UseCasesRecursiveVisitor
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@property UseCasesClosureParameterViewModel * _Nullable transformed;
@property (readonly) NSString *name;
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMakeFunctionCallVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesMakeFunctionCallVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (NSString * _Nullable)makeElement:(id<UseCasesElement>)element __attribute__((swift_name("make(element:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesOptionalizeIUOVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesOptionalizeIUOVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<UseCasesType>)optionalizeType:(id<UseCasesType>)type __attribute__((swift_name("optionalize(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesRecursiveRemoveOptionalVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesRecursiveRemoveOptionalVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<UseCasesType>)removeOptionalType:(id<UseCasesType>)type __attribute__((swift_name("removeOptional(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesRemoveOptionalVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesRemoveOptionalVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<UseCasesType>)removeOptionalType:(id<UseCasesType>)type __attribute__((swift_name("removeOptional(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSignatureGenerator : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSignatureGeneratorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (NSString *)signatureElement:(id<UseCasesElement>)element __attribute__((swift_name("signature(element:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSurroundOptionalVisitor : UseCasesVisitor
- (instancetype)initWithUnwrapped:(BOOL)unwrapped __attribute__((swift_name("init(unwrapped:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesSurroundOptionalVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<UseCasesType>)surroundType:(id<UseCasesType>)type unwrapped:(BOOL)unwrapped __attribute__((swift_name("surround(type:unwrapped:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeErasingVisitor : UseCasesRecursiveVisitor
- (instancetype)initWithGenericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("init(genericIdentifiers:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesTypeErasingVisitorCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (void)eraseType:(id<UseCasesType>)type genericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("erase(type:genericIdentifiers:)")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesStdlibUnit : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)unit __attribute__((swift_name("init()")));
@end;

__attribute__((objc_subclassing_restricted))
@interface UseCasesStdlibArray : KotlinBase
+ (instancetype)arrayWithSize:(int32_t)size init:(id _Nullable (^)(NSNumber *))init __attribute__((swift_name("init(size:init:)")));
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (id _Nullable)getIndex:(int32_t)index __attribute__((swift_name("get(index:)")));
- (id<UseCasesStdlibIterator>)iterator __attribute__((swift_name("iterator()")));
- (void)setIndex:(int32_t)index value:(id _Nullable)value __attribute__((swift_name("set(index:value:)")));
@property (readonly) int32_t size;
@end;

@protocol UseCasesStdlibIterator
@required
- (BOOL)hasNext __attribute__((swift_name("hasNext()")));
- (id _Nullable)next __attribute__((swift_name("next()")));
@end;

NS_ASSUME_NONNULL_END
