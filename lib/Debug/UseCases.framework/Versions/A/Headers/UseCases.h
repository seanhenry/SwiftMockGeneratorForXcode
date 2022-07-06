#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSError.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>

@class UseCasesInitialiserCall, UseCasesDefaultValueStore, UseCasesInitializer, UseCasesTuplePropertyDeclaration, UseCasesVisitor, UseCasesArrayType, UseCasesArrayTypeBuilder, UseCasesTypeFactory<B>, UseCasesProperty, UseCasesMethod, UseCasesSubscript, UseCasesProtocol, UseCasesTypeDeclaration, UseCasesClass, UseCasesClassBuilder, UseCasesInitializerBuilder, UseCasesPropertyBuilder, UseCasesMethodBuilder, UseCasesSubscriptBuilder, UseCasesDictionaryType, UseCasesDictionaryTypeBuilder, UseCasesFunctionType, UseCasesFunctionTypeBuilder, UseCasesGenericType, UseCasesGenericTypeBuilder, UseCasesParameter, UseCasesParameterBuilder, UseCasesResolvedType, UseCasesMockClassBuilder, UseCasesProtocolBuilder, UseCasesMockClass, UseCasesOptionalType, UseCasesOptionalTypeBuilder, UseCasesPropertyDeclarationCompanion, UseCasesPropertyDeclaration, UseCasesResolvedTypeCompanion, UseCasesTypeIdentifier, UseCasesTuplePropertyDeclarationTupleParameter, UseCasesTuplePropertyDeclarationCompanion, UseCasesTupleTypeTupleElement, UseCasesTupleType, UseCasesTupleTypeBuilder, UseCasesTypeIdentifierBuilder, UseCasesTypeIdentifierCompanion, UseCasesMockViewModel, UseCasesKotlinArray<T>, UseCasesInitializerViewModel, UseCasesPropertyViewModel, UseCasesMethodViewModel, UseCasesSubscriptViewModel, UseCasesParametersViewModel, UseCasesClosureParameterViewModel, UseCasesResultTypeViewModel, UseCasesStringDecorator, UseCasesClosureUtilCompanion, UseCasesParameterUtilCompanion, UseCasesMethodModel, UseCasesCreateParameterTuple, UseCasesCopyVisitorCompanion, UseCasesDefaultValueVisitorCompanion, UseCasesRecursiveVisitor, UseCasesMakeFunctionCallVisitorCompanion, UseCasesOptionalizeIUOVisitorCompanion, UseCasesRecursiveRemoveOptionalVisitorCompanion, UseCasesRemoveOptionalVisitorCompanion, UseCasesSignatureGeneratorCompanion, UseCasesSurroundOptionalVisitorCompanion, UseCasesTypeErasingVisitorCompanion;

@protocol UseCasesElement, UseCasesType, UseCasesMockView, UseCasesMockTransformer, UseCasesKotlinIterator;

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-warning-option"
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wnullability"

#pragma push_macro("_Nullable_result")
#if !__has_feature(nullability_nullable_result)
#undef _Nullable_result
#define _Nullable_result _Nullable
#endif

__attribute__((swift_name("KotlinBase")))
@interface UseCasesBase : NSObject
- (instancetype)init __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
+ (void)initialize __attribute__((objc_requires_super));
@end;

@interface UseCasesBase (UseCasesBaseCopying) <NSCopying>
@end;

__attribute__((swift_name("KotlinMutableSet")))
@interface UseCasesMutableSet<ObjectType> : NSMutableSet<ObjectType>
@end;

__attribute__((swift_name("KotlinMutableDictionary")))
@interface UseCasesMutableDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>
@end;

@interface NSError (NSErrorUseCasesKotlinException)
@property (readonly) id _Nullable kotlinException;
@end;

__attribute__((swift_name("KotlinNumber")))
@interface UseCasesNumber : NSNumber
- (instancetype)initWithChar:(char)value __attribute__((unavailable));
- (instancetype)initWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
- (instancetype)initWithShort:(short)value __attribute__((unavailable));
- (instancetype)initWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
- (instancetype)initWithInt:(int)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
- (instancetype)initWithLong:(long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
- (instancetype)initWithLongLong:(long long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
- (instancetype)initWithFloat:(float)value __attribute__((unavailable));
- (instancetype)initWithDouble:(double)value __attribute__((unavailable));
- (instancetype)initWithBool:(BOOL)value __attribute__((unavailable));
- (instancetype)initWithInteger:(NSInteger)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
+ (instancetype)numberWithChar:(char)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
+ (instancetype)numberWithShort:(short)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
+ (instancetype)numberWithInt:(int)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
+ (instancetype)numberWithLong:(long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
+ (instancetype)numberWithLongLong:(long long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
+ (instancetype)numberWithFloat:(float)value __attribute__((unavailable));
+ (instancetype)numberWithDouble:(double)value __attribute__((unavailable));
+ (instancetype)numberWithBool:(BOOL)value __attribute__((unavailable));
+ (instancetype)numberWithInteger:(NSInteger)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
@end;

__attribute__((swift_name("KotlinByte")))
@interface UseCasesByte : UseCasesNumber
- (instancetype)initWithChar:(char)value;
+ (instancetype)numberWithChar:(char)value;
@end;

__attribute__((swift_name("KotlinUByte")))
@interface UseCasesUByte : UseCasesNumber
- (instancetype)initWithUnsignedChar:(unsigned char)value;
+ (instancetype)numberWithUnsignedChar:(unsigned char)value;
@end;

__attribute__((swift_name("KotlinShort")))
@interface UseCasesShort : UseCasesNumber
- (instancetype)initWithShort:(short)value;
+ (instancetype)numberWithShort:(short)value;
@end;

__attribute__((swift_name("KotlinUShort")))
@interface UseCasesUShort : UseCasesNumber
- (instancetype)initWithUnsignedShort:(unsigned short)value;
+ (instancetype)numberWithUnsignedShort:(unsigned short)value;
@end;

__attribute__((swift_name("KotlinInt")))
@interface UseCasesInt : UseCasesNumber
- (instancetype)initWithInt:(int)value;
+ (instancetype)numberWithInt:(int)value;
@end;

__attribute__((swift_name("KotlinUInt")))
@interface UseCasesUInt : UseCasesNumber
- (instancetype)initWithUnsignedInt:(unsigned int)value;
+ (instancetype)numberWithUnsignedInt:(unsigned int)value;
@end;

__attribute__((swift_name("KotlinLong")))
@interface UseCasesLong : UseCasesNumber
- (instancetype)initWithLongLong:(long long)value;
+ (instancetype)numberWithLongLong:(long long)value;
@end;

__attribute__((swift_name("KotlinULong")))
@interface UseCasesULong : UseCasesNumber
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value;
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value;
@end;

__attribute__((swift_name("KotlinFloat")))
@interface UseCasesFloat : UseCasesNumber
- (instancetype)initWithFloat:(float)value;
+ (instancetype)numberWithFloat:(float)value;
@end;

__attribute__((swift_name("KotlinDouble")))
@interface UseCasesDouble : UseCasesNumber
- (instancetype)initWithDouble:(double)value;
+ (instancetype)numberWithDouble:(double)value;
@end;

__attribute__((swift_name("KotlinBoolean")))
@interface UseCasesBoolean : UseCasesNumber
- (instancetype)initWithBool:(BOOL)value;
+ (instancetype)numberWithBool:(BOOL)value;
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SwiftStringConvenienceInitCall")))
@interface UseCasesSwiftStringConvenienceInitCall : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformCall:(UseCasesInitialiserCall *)call __attribute__((swift_name("transform(call:)")));
@property (readonly) UseCasesDefaultValueStore *store __attribute__((swift_name("store")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SwiftStringInitialiserDeclaration")))
@interface UseCasesSwiftStringInitialiserDeclaration : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformCall:(UseCasesInitialiserCall *)call __attribute__((swift_name("transform(call:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SwiftStringProtocolInitialiserDeclaration")))
@interface UseCasesSwiftStringProtocolInitialiserDeclaration : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformInitializer:(UseCasesInitializer *)initializer __attribute__((swift_name("transform(initializer:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SwiftStringTupleForwardCall")))
@interface UseCasesSwiftStringTupleForwardCall : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString *)transformProperty:(UseCasesTuplePropertyDeclaration *)property __attribute__((swift_name("transform(property:)")));
@end;

__attribute__((swift_name("Element")))
@protocol UseCasesElement
@required
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
@end;

__attribute__((swift_name("Type")))
@protocol UseCasesType <UseCasesElement>
@required
@property (readonly) NSString *text __attribute__((swift_name("text")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ArrayType")))
@interface UseCasesArrayType : UseCasesBase <UseCasesType>
- (instancetype)initWithType:(id<UseCasesType>)type useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(type:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesArrayType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesArrayType *)doCopyType:(id<UseCasesType>)type useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(type:useVerboseSyntax:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) id<UseCasesType> type __attribute__((swift_name("type")));
@property BOOL useVerboseSyntax __attribute__((swift_name("useVerboseSyntax")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ArrayType.Builder")))
@interface UseCasesArrayTypeBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesArrayTypeBuilder *)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (UseCasesTypeFactory<UseCasesArrayTypeBuilder *> *)type __attribute__((swift_name("type()")));
- (UseCasesArrayTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesArrayType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((swift_name("TypeDeclaration")))
@interface UseCasesTypeDeclaration : UseCasesBase
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesInitializer *> *initializers __attribute__((swift_name("initializers")));
@property (readonly) NSArray<UseCasesProperty *> *properties __attribute__((swift_name("properties")));
@property (readonly) NSArray<UseCasesMethod *> *methods __attribute__((swift_name("methods")));
@property (readonly) NSArray<UseCasesSubscript *> *subscripts __attribute__((swift_name("subscripts")));
@property (readonly) NSArray<UseCasesProtocol *> *protocols __attribute__((swift_name("protocols")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Class")))
@interface UseCasesClass : UseCasesTypeDeclaration
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts inheritedClass:(UseCasesClass * _Nullable)inheritedClass __attribute__((swift_name("init(initializers:properties:methods:subscripts:inheritedClass:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (readonly) UseCasesClass * _Nullable inheritedClass __attribute__((swift_name("inheritedClass")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Class.Builder")))
@interface UseCasesClassBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesClassBuilder *)initializerBuild:(void (^)(UseCasesInitializerBuilder *))build __attribute__((swift_name("initializer(build:)")));
- (UseCasesClassBuilder *)propertyName:(NSString *)name build:(void (^)(UseCasesPropertyBuilder *))build __attribute__((swift_name("property(name:build:)")));
- (UseCasesClassBuilder *)methodName:(NSString *)name build:(void (^)(UseCasesMethodBuilder *))build __attribute__((swift_name("method(name:build:)")));
- (UseCasesClassBuilder *)subscriptReturnType:(id<UseCasesType>)returnType build:(void (^)(UseCasesSubscriptBuilder *))build __attribute__((swift_name("subscript(returnType:build:)")));
- (UseCasesClassBuilder *)superclassBuild:(void (^)(UseCasesClassBuilder *))build __attribute__((swift_name("superclass(build:)")));
- (UseCasesClass *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DictionaryType")))
@interface UseCasesDictionaryType : UseCasesBase <UseCasesType>
- (instancetype)initWithKeyType:(id<UseCasesType>)keyType valueType:(id<UseCasesType>)valueType useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(keyType:valueType:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesDictionaryType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesDictionaryType *)doCopyKeyType:(id<UseCasesType>)keyType valueType:(id<UseCasesType>)valueType useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(keyType:valueType:useVerboseSyntax:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property id<UseCasesType> keyType __attribute__((swift_name("keyType")));
@property (readonly) id<UseCasesType> valueType __attribute__((swift_name("valueType")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DictionaryType.Builder")))
@interface UseCasesDictionaryTypeBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesDictionaryTypeBuilder *)keyTypeType:(NSString *)type __attribute__((swift_name("keyType(type:)")));
- (UseCasesTypeFactory<UseCasesDictionaryTypeBuilder *> *)keyType __attribute__((swift_name("keyType()")));
- (UseCasesDictionaryTypeBuilder *)valueTypeType:(NSString *)type __attribute__((swift_name("valueType(type:)")));
- (UseCasesTypeFactory<UseCasesDictionaryTypeBuilder *> *)valueType __attribute__((swift_name("valueType()")));
- (UseCasesDictionaryTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesDictionaryType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("FunctionType")))
@interface UseCasesFunctionType : UseCasesBase <UseCasesType>
- (instancetype)initWithArguments:(NSArray<id<UseCasesType>> *)arguments returnType:(id<UseCasesType>)returnType throws:(BOOL)throws __attribute__((swift_name("init(arguments:returnType:throws:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesFunctionType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSArray<id<UseCasesType>> *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component3 __attribute__((swift_name("component3()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesFunctionType *)doCopyArguments:(NSArray<id<UseCasesType>> *)arguments returnType:(id<UseCasesType>)returnType throws:(BOOL)throws __attribute__((swift_name("doCopy(arguments:returnType:throws:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) NSArray<id<UseCasesType>> *arguments __attribute__((swift_name("arguments")));
@property (readonly) id<UseCasesType> returnType __attribute__((swift_name("returnType")));
@property (readonly) BOOL throws __attribute__((swift_name("throws")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("FunctionType.Builder")))
@interface UseCasesFunctionTypeBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesFunctionTypeBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesFunctionTypeBuilder *)argumentType:(NSString *)type __attribute__((swift_name("argument(type:)")));
- (UseCasesTypeFactory<UseCasesFunctionTypeBuilder *> *)argument __attribute__((swift_name("argument()")));
- (UseCasesFunctionTypeBuilder *)returnTypeType:(NSString *)type __attribute__((swift_name("returnType(type:)")));
- (UseCasesTypeFactory<UseCasesFunctionTypeBuilder *> *)returnType __attribute__((swift_name("returnType()")));
- (UseCasesFunctionType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GenericType")))
@interface UseCasesGenericType : UseCasesBase <UseCasesType>
- (instancetype)initWithIdentifier:(NSString *)identifier arguments:(NSArray<id<UseCasesType>> *)arguments __attribute__((swift_name("init(identifier:arguments:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesGenericType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSString *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (NSArray<id<UseCasesType>> *)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesGenericType *)doCopyIdentifier:(NSString *)identifier arguments:(NSArray<id<UseCasesType>> *)arguments __attribute__((swift_name("doCopy(identifier:arguments:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) NSString *identifier __attribute__((swift_name("identifier")));
@property (readonly) NSArray<id<UseCasesType>> *arguments __attribute__((swift_name("arguments")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GenericType.Builder")))
@interface UseCasesGenericTypeBuilder : UseCasesBase
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (UseCasesGenericTypeBuilder *)argumentIdentifier:(NSString *)identifier __attribute__((swift_name("argument(identifier:)")));
- (UseCasesTypeFactory<UseCasesGenericTypeBuilder *> *)argument __attribute__((swift_name("argument()")));
- (UseCasesGenericType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("InitialiserCall")))
@interface UseCasesInitialiserCall : UseCasesBase
- (instancetype)initWithParameters:(NSArray<UseCasesParameter *> *)parameters isFailable:(BOOL)isFailable __attribute__((swift_name("init(parameters:isFailable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithParameters:(NSArray<UseCasesParameter *> *)parameters isFailable:(BOOL)isFailable throws:(BOOL)throws __attribute__((swift_name("init(parameters:isFailable:throws:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSArray<UseCasesParameter *> *parameters __attribute__((swift_name("parameters")));
@property (readonly) BOOL isFailable __attribute__((swift_name("isFailable")));
@property (readonly) BOOL throws __attribute__((swift_name("throws")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Initializer")))
@interface UseCasesInitializer : UseCasesBase <UseCasesElement>
- (instancetype)initWithParametersList:(NSArray<UseCasesParameter *> *)parametersList isFailable:(BOOL)isFailable throws:(BOOL)throws __attribute__((swift_name("init(parametersList:isFailable:throws:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
@property (readonly) NSArray<UseCasesParameter *> *parametersList __attribute__((swift_name("parametersList")));
@property (readonly) BOOL isFailable __attribute__((swift_name("isFailable")));
@property (readonly) BOOL throws __attribute__((swift_name("throws")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Initializer.Builder")))
@interface UseCasesInitializerBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesInitializerBuilder *)failable __attribute__((swift_name("failable()")));
- (UseCasesInitializerBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesInitializerBuilder *)parameterName:(NSString *)name build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesInitializerBuilder *)parameterExternalName:(NSString *)externalName internalName:(NSString *)internalName build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesInitializer *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Method")))
@interface UseCasesMethod : UseCasesBase <UseCasesElement>
- (instancetype)initWithName:(NSString *)name genericParameters:(NSArray<NSString *> *)genericParameters returnType:(UseCasesResolvedType *)returnType parametersList:(NSArray<UseCasesParameter *> *)parametersList declarationText:(NSString *)declarationText throws:(BOOL)throws rethrows:(BOOL)rethrows __attribute__((swift_name("init(name:genericParameters:returnType:parametersList:declarationText:throws:rethrows:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSString *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (NSArray<NSString *> *)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesResolvedType *)component3 __attribute__((swift_name("component3()"))) __attribute__((deprecated("use corresponding property instead")));
- (NSArray<UseCasesParameter *> *)component4 __attribute__((swift_name("component4()"))) __attribute__((deprecated("use corresponding property instead")));
- (NSString *)component5 __attribute__((swift_name("component5()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component6 __attribute__((swift_name("component6()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component7 __attribute__((swift_name("component7()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesMethod *)doCopyName:(NSString *)name genericParameters:(NSArray<NSString *> *)genericParameters returnType:(UseCasesResolvedType *)returnType parametersList:(NSArray<UseCasesParameter *> *)parametersList declarationText:(NSString *)declarationText throws:(BOOL)throws rethrows:(BOOL)rethrows __attribute__((swift_name("doCopy(name:genericParameters:returnType:parametersList:declarationText:throws:rethrows:)")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) NSArray<NSString *> *genericParameters __attribute__((swift_name("genericParameters")));
@property (readonly) UseCasesResolvedType *returnType __attribute__((swift_name("returnType")));
@property (readonly) NSArray<UseCasesParameter *> *parametersList __attribute__((swift_name("parametersList")));
@property (readonly) NSString *declarationText __attribute__((swift_name("declarationText")));
@property (readonly) BOOL throws __attribute__((swift_name("throws")));
@property (readonly) BOOL rethrows __attribute__((swift_name("rethrows")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Method.Builder")))
@interface UseCasesMethodBuilder : UseCasesBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (UseCasesMethod *)build __attribute__((swift_name("build()")));
- (UseCasesMethodBuilder *)returnTypeType:(NSString *)type __attribute__((swift_name("returnType(type:)")));
- (UseCasesTypeFactory<UseCasesMethodBuilder *> *)returnType __attribute__((swift_name("returnType()")));
- (UseCasesMethodBuilder *)throws __attribute__((swift_name("throws()")));
- (UseCasesMethodBuilder *)rethrows __attribute__((swift_name("rethrows()")));
- (UseCasesMethodBuilder *)parameterName:(NSString *)name build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesMethodBuilder *)parameterExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesMethodBuilder *)genericParameterIdentifier:(NSString *)identifier __attribute__((swift_name("genericParameter(identifier:)")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MockClass")))
@interface UseCasesMockClass : UseCasesTypeDeclaration
- (instancetype)initWithInheritedClass:(UseCasesClass * _Nullable)inheritedClass protocols:(NSArray<UseCasesProtocol *> *)protocols scope:(NSString * _Nullable)scope __attribute__((swift_name("init(inheritedClass:protocols:scope:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (readonly) UseCasesClass * _Nullable inheritedClass __attribute__((swift_name("inheritedClass")));
@property (readonly) NSString * _Nullable scope __attribute__((swift_name("scope")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MockClass.Builder")))
@interface UseCasesMockClassBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesMockClassBuilder *)superclassBuild:(void (^)(UseCasesClassBuilder *))build __attribute__((swift_name("superclass(build:)")));
- (UseCasesMockClassBuilder *)protocolBuild:(void (^)(UseCasesProtocolBuilder *))build __attribute__((swift_name("protocol(build:)")));
- (UseCasesMockClassBuilder *)scopeScope:(NSString *)scope __attribute__((swift_name("scope(scope:)")));
- (UseCasesMockClass *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("OptionalType")))
@interface UseCasesOptionalType : UseCasesBase <UseCasesType>
- (instancetype)initWithType:(id<UseCasesType>)type isImplicitlyUnwrapped:(BOOL)isImplicitlyUnwrapped useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("init(type:isImplicitlyUnwrapped:useVerboseSyntax:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesOptionalType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component3 __attribute__((swift_name("component3()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesOptionalType *)doCopyType:(id<UseCasesType>)type isImplicitlyUnwrapped:(BOOL)isImplicitlyUnwrapped useVerboseSyntax:(BOOL)useVerboseSyntax __attribute__((swift_name("doCopy(type:isImplicitlyUnwrapped:useVerboseSyntax:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) id<UseCasesType> type __attribute__((swift_name("type")));
@property (readonly) BOOL isImplicitlyUnwrapped __attribute__((swift_name("isImplicitlyUnwrapped")));
@property (readonly) BOOL useVerboseSyntax __attribute__((swift_name("useVerboseSyntax")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("OptionalType.Builder")))
@interface UseCasesOptionalTypeBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesOptionalTypeBuilder *)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (UseCasesOptionalTypeBuilder *)typeType_:(id<UseCasesType>)type __attribute__((swift_name("type(type_:)")));
- (UseCasesTypeFactory<UseCasesOptionalTypeBuilder *> *)type __attribute__((swift_name("type()")));
- (UseCasesOptionalTypeBuilder *)unwrapped __attribute__((swift_name("unwrapped()")));
- (UseCasesOptionalTypeBuilder *)verbose __attribute__((swift_name("verbose()")));
- (UseCasesOptionalType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((swift_name("Parameter")))
@interface UseCasesParameter : UseCasesBase <UseCasesElement>
- (instancetype)initWithExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName type:(UseCasesResolvedType *)type text:(NSString *)text isEscaping:(BOOL)isEscaping __attribute__((swift_name("init(externalName:internalName:type:text:isEscaping:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
@property (readonly) NSString *originalTypeText __attribute__((swift_name("originalTypeText")));
@property (readonly) NSString *resolvedTypeText __attribute__((swift_name("resolvedTypeText")));
@property (readonly) NSString * _Nullable externalName __attribute__((swift_name("externalName")));
@property (readonly) NSString *internalName __attribute__((swift_name("internalName")));
@property (readonly) UseCasesResolvedType *type __attribute__((swift_name("type")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) BOOL isEscaping __attribute__((swift_name("isEscaping")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Parameter.Builder")))
@interface UseCasesParameterBuilder : UseCasesBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName __attribute__((swift_name("init(externalName:internalName:)"))) __attribute__((objc_designated_initializer));
- (UseCasesParameterBuilder *)typeString:(NSString *)string __attribute__((swift_name("type(string:)")));
- (UseCasesTypeFactory<UseCasesParameterBuilder *> *)type __attribute__((swift_name("type()")));
- (UseCasesTypeFactory<UseCasesParameterBuilder *> *)resolvedType __attribute__((swift_name("resolvedType()")));
- (UseCasesParameterBuilder *)escaping __attribute__((swift_name("escaping()")));
- (UseCasesParameterBuilder *)annotationAnnotation:(NSString *)annotation __attribute__((swift_name("annotation(annotation:)")));
- (UseCasesParameterBuilder *)inout __attribute__((swift_name("inout()")));
- (UseCasesParameter *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Property")))
@interface UseCasesProperty : UseCasesBase <UseCasesElement>
- (instancetype)initWithName:(NSString *)name type:(id<UseCasesType>)type isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("init(name:type:isWritable:declarationText:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (NSString *)getTrimmedDeclarationText __attribute__((swift_name("getTrimmedDeclarationText()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSString *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (BOOL)component3 __attribute__((swift_name("component3()"))) __attribute__((deprecated("use corresponding property instead")));
- (NSString *)component4 __attribute__((swift_name("component4()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesProperty *)doCopyName:(NSString *)name type:(id<UseCasesType>)type isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("doCopy(name:type:isWritable:declarationText:)")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) id<UseCasesType> type __attribute__((swift_name("type")));
@property (readonly) BOOL isWritable __attribute__((swift_name("isWritable")));
@property (readonly) NSString *declarationText __attribute__((swift_name("declarationText")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Property.Builder")))
@interface UseCasesPropertyBuilder : UseCasesBase
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (UseCasesPropertyBuilder *)readonly __attribute__((swift_name("readonly()")));
- (UseCasesPropertyBuilder *)typeIdentifier:(NSString *)identifier __attribute__((swift_name("type(identifier:)")));
- (UseCasesTypeFactory<UseCasesPropertyBuilder *> *)type __attribute__((swift_name("type()")));
- (UseCasesProperty *)build __attribute__((swift_name("build()")));
@end;

__attribute__((swift_name("PropertyDeclaration")))
@interface UseCasesPropertyDeclaration : UseCasesBase
- (instancetype)initWithName:(NSString *)name type:(NSString *)type __attribute__((swift_name("init(name:type:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) UseCasesPropertyDeclarationCompanion *companion __attribute__((swift_name("companion")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) NSString *type __attribute__((swift_name("type")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("PropertyDeclaration.Companion")))
@interface UseCasesPropertyDeclarationCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesPropertyDeclarationCompanion *shared __attribute__((swift_name("shared")));
@property (readonly) UseCasesPropertyDeclaration *EMPTY __attribute__((swift_name("EMPTY")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Protocol")))
@interface UseCasesProtocol : UseCasesTypeDeclaration
- (instancetype)initWithInitializers:(NSArray<UseCasesInitializer *> *)initializers properties:(NSArray<UseCasesProperty *> *)properties methods:(NSArray<UseCasesMethod *> *)methods subscripts:(NSArray<UseCasesSubscript *> *)subscripts protocols:(NSArray<UseCasesProtocol *> *)protocols __attribute__((swift_name("init(initializers:properties:methods:subscripts:protocols:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Protocol.Builder")))
@interface UseCasesProtocolBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesProtocolBuilder *)initializerBuild:(void (^)(UseCasesInitializerBuilder *))build __attribute__((swift_name("initializer(build:)")));
- (UseCasesProtocolBuilder *)propertyName:(NSString *)name build:(void (^)(UseCasesPropertyBuilder *))build __attribute__((swift_name("property(name:build:)")));
- (UseCasesProtocolBuilder *)methodName:(NSString *)name build:(void (^)(UseCasesMethodBuilder *))build __attribute__((swift_name("method(name:build:)")));
- (UseCasesProtocolBuilder *)subscriptType:(id<UseCasesType>)type build:(void (^)(UseCasesSubscriptBuilder *))build __attribute__((swift_name("subscript(type:build:)")));
- (UseCasesProtocolBuilder *)protocolBuild:(void (^)(UseCasesProtocolBuilder *))build __attribute__((swift_name("protocol(build:)")));
- (UseCasesProtocol *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResolvedType")))
@interface UseCasesResolvedType : UseCasesBase
- (instancetype)initWithOriginalType:(id<UseCasesType>)originalType resolvedType:(id<UseCasesType>)resolvedType __attribute__((swift_name("init(originalType:resolvedType:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) UseCasesResolvedTypeCompanion *companion __attribute__((swift_name("companion")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (id<UseCasesType>)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesResolvedType *)doCopyOriginalType:(id<UseCasesType>)originalType resolvedType:(id<UseCasesType>)resolvedType __attribute__((swift_name("doCopy(originalType:resolvedType:)")));
@property id<UseCasesType> originalType __attribute__((swift_name("originalType")));
@property id<UseCasesType> resolvedType __attribute__((swift_name("resolvedType")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResolvedType.Companion")))
@interface UseCasesResolvedTypeCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesResolvedTypeCompanion *shared __attribute__((swift_name("shared")));
@property (readonly) UseCasesResolvedType *IMPLICIT __attribute__((swift_name("IMPLICIT")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResolvedType.Builder")))
@interface UseCasesResolvedTypeBuilder : UseCasesBase
- (instancetype)initWithType:(NSString *)type __attribute__((swift_name("init(type:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithOriginalType:(UseCasesTypeIdentifier *)originalType resolvedType:(UseCasesTypeIdentifier *)resolvedType __attribute__((swift_name("init(originalType:resolvedType:)"))) __attribute__((objc_designated_initializer));
- (UseCasesResolvedType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Subscript")))
@interface UseCasesSubscript : UseCasesBase <UseCasesElement>
- (instancetype)initWithReturnType:(UseCasesResolvedType *)returnType parameters:(NSArray<UseCasesParameter *> *)parameters isWritable:(BOOL)isWritable declarationText:(NSString *)declarationText __attribute__((swift_name("init(returnType:parameters:isWritable:declarationText:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
@property (readonly) UseCasesResolvedType *returnType __attribute__((swift_name("returnType")));
@property (readonly) NSArray<UseCasesParameter *> *parameters __attribute__((swift_name("parameters")));
@property (readonly) BOOL isWritable __attribute__((swift_name("isWritable")));
@property (readonly) NSString *declarationText __attribute__((swift_name("declarationText")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Subscript.Builder")))
@interface UseCasesSubscriptBuilder : UseCasesBase
- (instancetype)initWithReturnType:(id<UseCasesType>)returnType __attribute__((swift_name("init(returnType:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithReturnType_:(UseCasesResolvedType *)returnType __attribute__((swift_name("init(returnType_:)"))) __attribute__((objc_designated_initializer));
- (UseCasesSubscriptBuilder *)parameterName:(NSString *)name build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(name:build:)")));
- (UseCasesSubscriptBuilder *)parameterExternalName:(NSString * _Nullable)externalName internalName:(NSString *)internalName build:(void (^)(UseCasesParameterBuilder *))build __attribute__((swift_name("parameter(externalName:internalName:build:)")));
- (UseCasesSubscriptBuilder *)readonly __attribute__((swift_name("readonly()")));
- (UseCasesSubscript *)build __attribute__((swift_name("build()")));
@property (readonly) UseCasesResolvedType *returnType __attribute__((swift_name("returnType")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TuplePropertyDeclaration")))
@interface UseCasesTuplePropertyDeclaration : UseCasesBase
- (instancetype)initWithParameters:(NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *)parameters __attribute__((swift_name("init(parameters:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithParameters:(NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *)parameters text:(NSString *)text __attribute__((swift_name("init(parameters:text:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) UseCasesTuplePropertyDeclarationCompanion *companion __attribute__((swift_name("companion")));
@property (readonly) NSArray<UseCasesTuplePropertyDeclarationTupleParameter *> *parameters __attribute__((swift_name("parameters")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TuplePropertyDeclaration.TupleParameter")))
@interface UseCasesTuplePropertyDeclarationTupleParameter : UseCasesBase
- (instancetype)initWithName:(NSString *)name type:(NSString *)type __attribute__((swift_name("init(name:type:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithName:(NSString *)name type:(NSString *)type resolvedType:(NSString *)resolvedType __attribute__((swift_name("init(name:type:resolvedType:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) NSString *type __attribute__((swift_name("type")));
@property (readonly) NSString *resolvedType __attribute__((swift_name("resolvedType")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TuplePropertyDeclaration.Companion")))
@interface UseCasesTuplePropertyDeclarationCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesTuplePropertyDeclarationCompanion *shared __attribute__((swift_name("shared")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TupleType")))
@interface UseCasesTupleType : UseCasesBase <UseCasesType>
- (instancetype)initWithTupleElements:(NSArray<UseCasesTupleTypeTupleElement *> *)tupleElements __attribute__((swift_name("init(tupleElements:)"))) __attribute__((objc_designated_initializer));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (UseCasesTupleType *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSArray<UseCasesTupleTypeTupleElement *> *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesTupleType *)doCopyTupleElements:(NSArray<UseCasesTupleTypeTupleElement *> *)tupleElements __attribute__((swift_name("doCopy(tupleElements:)")));
@property (readonly) NSArray<id> *labels __attribute__((swift_name("labels")));
@property (readonly) NSArray<id<UseCasesType>> *types __attribute__((swift_name("types")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) NSArray<UseCasesTupleTypeTupleElement *> *tupleElements __attribute__((swift_name("tupleElements")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TupleType.TupleElement")))
@interface UseCasesTupleTypeTupleElement : UseCasesBase
- (instancetype)initWithLabel:(NSString * _Nullable)label type:(id<UseCasesType>)type __attribute__((swift_name("init(label:type:)"))) __attribute__((objc_designated_initializer));
- (UseCasesTupleTypeTupleElement *)deepCopy __attribute__((swift_name("deepCopy()")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSString * _Nullable)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (id<UseCasesType>)component2 __attribute__((swift_name("component2()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesTupleTypeTupleElement *)doCopyLabel:(NSString * _Nullable)label type:(id<UseCasesType>)type __attribute__((swift_name("doCopy(label:type:)")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property (readonly) NSString * _Nullable label __attribute__((swift_name("label")));
@property (readonly) id<UseCasesType> type __attribute__((swift_name("type")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TupleType.Builder")))
@interface UseCasesTupleTypeBuilder : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesTupleTypeBuilder *)elementIdentifier:(NSString *)identifier __attribute__((swift_name("element(identifier:)")));
- (UseCasesTupleTypeBuilder *)elementType:(id<UseCasesType>)type __attribute__((swift_name("element(type:)")));
- (UseCasesTypeFactory<UseCasesTupleTypeBuilder *> *)element __attribute__((swift_name("element()")));
- (UseCasesTupleTypeBuilder *)labelledElementLabel:(NSString * _Nullable)label identifier:(NSString *)identifier __attribute__((swift_name("labelledElement(label:identifier:)")));
- (UseCasesTypeFactory<UseCasesTupleTypeBuilder *> *)labelledElementLabel:(NSString * _Nullable)label __attribute__((swift_name("labelledElement(label:)")));
- (UseCasesTupleType *)build __attribute__((swift_name("build()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeFactory")))
@interface UseCasesTypeFactory<B> : UseCasesBase
- (instancetype)initWithPreviousBuilder:(B _Nullable)previousBuilder getType:(void (^)(id<UseCasesType>))getType __attribute__((swift_name("init(previousBuilder:getType:)"))) __attribute__((objc_designated_initializer));
- (B _Nullable)functionBuild:(void (^)(UseCasesFunctionTypeBuilder *))build __attribute__((swift_name("function(build:)")));
- (B _Nullable)optionalBuild:(void (^)(UseCasesOptionalTypeBuilder *))build __attribute__((swift_name("optional(build:)")));
- (B _Nullable)arrayBuild:(void (^)(UseCasesArrayTypeBuilder *))build __attribute__((swift_name("array(build:)")));
- (B _Nullable)dictionaryBuild:(void (^)(UseCasesDictionaryTypeBuilder *))build __attribute__((swift_name("dictionary(build:)")));
- (B _Nullable)genericIdentifier:(NSString *)identifier build:(void (^)(UseCasesGenericTypeBuilder *))build __attribute__((swift_name("generic(identifier:build:)")));
- (UseCasesTypeFactory<B> *)bracket __attribute__((swift_name("bracket()")));
- (B _Nullable)typeType:(NSString *)type __attribute__((swift_name("type(type:)")));
- (B _Nullable)typeIdentifierIdentifier:(NSString *)identifier build:(void (^)(UseCasesTypeIdentifierBuilder *))build __attribute__((swift_name("typeIdentifier(identifier:build:)")));
- (B _Nullable)tupleBuild:(void (^)(UseCasesTupleTypeBuilder *))build __attribute__((swift_name("tuple(build:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeIdentifier")))
@interface UseCasesTypeIdentifier : UseCasesBase <UseCasesType>
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithIdentifiers:(NSMutableArray<NSString *> *)identifiers __attribute__((swift_name("init(identifiers:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) UseCasesTypeIdentifierCompanion *companion __attribute__((swift_name("companion")));
- (void)acceptVisitor:(UseCasesVisitor *)visitor __attribute__((swift_name("accept(visitor:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
- (NSMutableArray<NSString *> *)component1 __attribute__((swift_name("component1()"))) __attribute__((deprecated("use corresponding property instead")));
- (UseCasesTypeIdentifier *)doCopyIdentifiers:(NSMutableArray<NSString *> *)identifiers __attribute__((swift_name("doCopy(identifiers:)")));
@property (readonly) BOOL isEmpty __attribute__((swift_name("isEmpty")));
@property (readonly) NSString *firstIdentifier __attribute__((swift_name("firstIdentifier")));
@property (readonly) NSString *text __attribute__((swift_name("text")));
@property NSMutableArray<NSString *> *identifiers __attribute__((swift_name("identifiers")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeIdentifier.Companion")))
@interface UseCasesTypeIdentifierCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesTypeIdentifierCompanion *shared __attribute__((swift_name("shared")));
- (BOOL)isVoidType:(id<UseCasesType>)type __attribute__((swift_name("isVoid(type:)")));
- (BOOL)isEmptyType:(id<UseCasesType>)type __attribute__((swift_name("isEmpty(type:)")));
@property (readonly) UseCasesTypeIdentifier *VOID __attribute__((swift_name("VOID")));
@property (readonly) UseCasesTupleType *EMPTY_TUPLE __attribute__((swift_name("EMPTY_TUPLE")));
@property (readonly) UseCasesTupleType *VOID_TUPLE __attribute__((swift_name("VOID_TUPLE")));
@property (readonly) UseCasesTypeIdentifier *EMPTY __attribute__((swift_name("EMPTY")));
@property (readonly) UseCasesTypeIdentifier *INT __attribute__((swift_name("INT")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeIdentifier.Builder")))
@interface UseCasesTypeIdentifierBuilder : UseCasesBase
- (instancetype)initWithIdentifier:(NSString *)identifier __attribute__((swift_name("init(identifier:)"))) __attribute__((objc_designated_initializer));
- (UseCasesTypeIdentifierBuilder *)nestIdentifier:(NSString *)identifier __attribute__((swift_name("nest(identifier:)")));
- (UseCasesTypeIdentifier *)build __attribute__((swift_name("build()")));
@end;

__attribute__((swift_name("MockView")))
@protocol UseCasesMockView
@required
- (void)renderModel:(UseCasesMockViewModel *)model __attribute__((swift_name("render(model:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CallbackMockView")))
@interface UseCasesCallbackMockView : UseCasesBase <UseCasesMockView>
- (instancetype)initWithCallback:(NSString *(^)(UseCasesMockViewModel *))callback __attribute__((swift_name("init(callback:)"))) __attribute__((objc_designated_initializer));
- (void)renderModel:(UseCasesMockViewModel *)model __attribute__((swift_name("render(model:)")));
@property NSArray<NSString *> *result __attribute__((swift_name("result")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Generator")))
@interface UseCasesGenerator : UseCasesBase
- (instancetype)initWithView:(id<UseCasesMockView>)view __attribute__((swift_name("init(view:)"))) __attribute__((objc_designated_initializer));
- (void)setC:(UseCasesMockClass *)c __attribute__((swift_name("set(c:)")));
- (NSString *)generate __attribute__((swift_name("generate()")));
@end;

__attribute__((swift_name("MockTransformer")))
@protocol UseCasesMockTransformer
@required
- (void)setScopeScope:(NSString *)scope __attribute__((swift_name("setScope(scope:)")));
- (void)addMethod:(UseCasesMethod *)method __attribute__((swift_name("add(method:)")));
- (void)addProperty:(UseCasesProperty *)property __attribute__((swift_name("add(property:)")));
- (void)addSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("add(subscript:)")));
- (void)addInitializers:(UseCasesKotlinArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("add(initializers:)")));
- (void)addMethods:(UseCasesKotlinArray<UseCasesMethod *> *)methods __attribute__((swift_name("add(methods:)")));
- (void)addProperties:(UseCasesKotlinArray<UseCasesProperty *> *)properties __attribute__((swift_name("add(properties:)")));
- (void)addSubscripts:(UseCasesKotlinArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("add(subscripts:)")));
- (void)addInitialisersInitializers:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("addInitialisers(initializers:)")));
- (void)addMethodsMethods:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addMethods(methods:)")));
- (void)addPropertiesProperties:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addProperties(properties:)")));
- (void)addSubscriptsSubscripts:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addSubscripts(subscripts:)")));
- (void)setClassInitialisersInitializers:(UseCasesKotlinArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("setClassInitialisers(initializers:)")));
- (void)setClassInitialisersInitializers_:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("setClassInitialisers(initializers_:)")));
- (void)addClassMethodsMethods:(UseCasesKotlinArray<UseCasesMethod *> *)methods __attribute__((swift_name("addClassMethods(methods:)")));
- (void)addClassMethodsMethods_:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addClassMethods(methods_:)")));
- (void)addClassPropertiesProperties:(UseCasesKotlinArray<UseCasesProperty *> *)properties __attribute__((swift_name("addClassProperties(properties:)")));
- (void)addClassPropertiesProperties_:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addClassProperties(properties_:)")));
- (void)addClassSubscriptsSubscripts:(UseCasesKotlinArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts:)")));
- (void)addClassSubscriptsSubscripts_:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts_:)")));
- (NSString *)generate __attribute__((swift_name("generate()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MockViewModel")))
@interface UseCasesMockViewModel : UseCasesBase
- (instancetype)initWithInitializer:(NSArray<UseCasesInitializerViewModel *> *)initializer property:(NSArray<UseCasesPropertyViewModel *> *)property method:(NSArray<UseCasesMethodViewModel *> *)method subscript:(NSArray<UseCasesSubscriptViewModel *> *)subscript scope:(NSString * _Nullable)scope __attribute__((swift_name("init(initializer:property:method:subscript:scope:)"))) __attribute__((objc_designated_initializer));
@property NSArray<UseCasesInitializerViewModel *> *initializer __attribute__((swift_name("initializer")));
@property NSArray<UseCasesPropertyViewModel *> *property __attribute__((swift_name("property")));
@property NSArray<UseCasesMethodViewModel *> *method __attribute__((swift_name("method")));
@property NSArray<UseCasesSubscriptViewModel *> *subscript __attribute__((swift_name("subscript")));
@property NSString * _Nullable scope __attribute__((swift_name("scope")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("PropertyViewModel")))
@interface UseCasesPropertyViewModel : UseCasesBase
- (instancetype)initWithName:(NSString *)name capitalizedUniqueName:(NSString *)capitalizedUniqueName hasSetter:(BOOL)hasSetter type:(NSString *)type optionalType:(NSString *)optionalType iuoType:(NSString *)iuoType defaultValueAssignment:(NSString *)defaultValueAssignment defaultValue:(NSString * _Nullable)defaultValue isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(name:capitalizedUniqueName:hasSetter:type:optionalType:iuoType:defaultValueAssignment:defaultValue:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *name __attribute__((swift_name("name")));
@property NSString *capitalizedUniqueName __attribute__((swift_name("capitalizedUniqueName")));
@property BOOL hasSetter __attribute__((swift_name("hasSetter")));
@property NSString *type __attribute__((swift_name("type")));
@property NSString *optionalType __attribute__((swift_name("optionalType")));
@property NSString *iuoType __attribute__((swift_name("iuoType")));
@property NSString *defaultValueAssignment __attribute__((swift_name("defaultValueAssignment")));
@property NSString * _Nullable defaultValue __attribute__((swift_name("defaultValue")));
@property BOOL isImplemented __attribute__((swift_name("isImplemented")));
@property NSString *declarationText __attribute__((swift_name("declarationText")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MethodViewModel")))
@interface UseCasesMethodViewModel : UseCasesBase
- (instancetype)initWithCapitalizedUniqueName:(NSString *)capitalizedUniqueName escapingParameters:(UseCasesParametersViewModel * _Nullable)escapingParameters closureParameter:(NSArray<UseCasesClosureParameterViewModel *> *)closureParameter resultType:(UseCasesResultTypeViewModel * _Nullable)resultType functionCall:(NSString * _Nullable)functionCall throws:(BOOL)throws rethrows:(BOOL)rethrows isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(capitalizedUniqueName:escapingParameters:closureParameter:resultType:functionCall:throws:rethrows:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedUniqueName __attribute__((swift_name("capitalizedUniqueName")));
@property UseCasesParametersViewModel * _Nullable escapingParameters __attribute__((swift_name("escapingParameters")));
@property NSArray<UseCasesClosureParameterViewModel *> *closureParameter __attribute__((swift_name("closureParameter")));
@property UseCasesResultTypeViewModel * _Nullable resultType __attribute__((swift_name("resultType")));
@property NSString * _Nullable functionCall __attribute__((swift_name("functionCall")));
@property BOOL throws __attribute__((swift_name("throws")));
@property BOOL rethrows __attribute__((swift_name("rethrows")));
@property BOOL isImplemented __attribute__((swift_name("isImplemented")));
@property NSString *declarationText __attribute__((swift_name("declarationText")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResultTypeViewModel")))
@interface UseCasesResultTypeViewModel : UseCasesBase
- (instancetype)initWithDefaultValueAssignment:(NSString *)defaultValueAssignment defaultValue:(NSString * _Nullable)defaultValue optionalType:(NSString *)optionalType iuoType:(NSString *)iuoType type:(NSString *)type returnCastStatement:(NSString *)returnCastStatement __attribute__((swift_name("init(defaultValueAssignment:defaultValue:optionalType:iuoType:type:returnCastStatement:)"))) __attribute__((objc_designated_initializer));
@property NSString *defaultValueAssignment __attribute__((swift_name("defaultValueAssignment")));
@property NSString * _Nullable defaultValue __attribute__((swift_name("defaultValue")));
@property NSString *optionalType __attribute__((swift_name("optionalType")));
@property NSString *iuoType __attribute__((swift_name("iuoType")));
@property NSString *type __attribute__((swift_name("type")));
@property NSString *returnCastStatement __attribute__((swift_name("returnCastStatement")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ParametersViewModel")))
@interface UseCasesParametersViewModel : UseCasesBase
- (instancetype)initWithTupleRepresentation:(NSString *)tupleRepresentation tupleAssignment:(NSString *)tupleAssignment __attribute__((swift_name("init(tupleRepresentation:tupleAssignment:)"))) __attribute__((objc_designated_initializer));
@property NSString *tupleRepresentation __attribute__((swift_name("tupleRepresentation")));
@property NSString *tupleAssignment __attribute__((swift_name("tupleAssignment")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ClosureParameterViewModel")))
@interface UseCasesClosureParameterViewModel : UseCasesBase
- (instancetype)initWithCapitalizedName:(NSString *)capitalizedName name:(NSString *)name argumentsTupleRepresentation:(NSString *)argumentsTupleRepresentation implicitClosureCall:(NSString *)implicitClosureCall hasArguments:(BOOL)hasArguments __attribute__((swift_name("init(capitalizedName:name:argumentsTupleRepresentation:implicitClosureCall:hasArguments:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedName __attribute__((swift_name("capitalizedName")));
@property NSString *name __attribute__((swift_name("name")));
@property NSString *argumentsTupleRepresentation __attribute__((swift_name("argumentsTupleRepresentation")));
@property NSString *implicitClosureCall __attribute__((swift_name("implicitClosureCall")));
@property BOOL hasArguments __attribute__((swift_name("hasArguments")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("InitializerViewModel")))
@interface UseCasesInitializerViewModel : UseCasesBase
- (instancetype)initWithDeclarationText:(NSString *)declarationText initializerCall:(NSString *)initializerCall __attribute__((swift_name("init(declarationText:initializerCall:)"))) __attribute__((objc_designated_initializer));
@property NSString *declarationText __attribute__((swift_name("declarationText")));
@property NSString *initializerCall __attribute__((swift_name("initializerCall")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SubscriptViewModel")))
@interface UseCasesSubscriptViewModel : UseCasesBase
- (instancetype)initWithCapitalizedUniqueName:(NSString *)capitalizedUniqueName escapingParameters:(UseCasesParametersViewModel * _Nullable)escapingParameters hasSetter:(BOOL)hasSetter resultType:(UseCasesResultTypeViewModel *)resultType functionCall:(NSString * _Nullable)functionCall isImplemented:(BOOL)isImplemented declarationText:(NSString *)declarationText __attribute__((swift_name("init(capitalizedUniqueName:escapingParameters:hasSetter:resultType:functionCall:isImplemented:declarationText:)"))) __attribute__((objc_designated_initializer));
@property NSString *capitalizedUniqueName __attribute__((swift_name("capitalizedUniqueName")));
@property UseCasesParametersViewModel * _Nullable escapingParameters __attribute__((swift_name("escapingParameters")));
@property BOOL hasSetter __attribute__((swift_name("hasSetter")));
@property UseCasesResultTypeViewModel *resultType __attribute__((swift_name("resultType")));
@property NSString * _Nullable functionCall __attribute__((swift_name("functionCall")));
@property BOOL isImplemented __attribute__((swift_name("isImplemented")));
@property NSString *declarationText __attribute__((swift_name("declarationText")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MockViewPresenter")))
@interface UseCasesMockViewPresenter : UseCasesBase <UseCasesMockTransformer>
- (instancetype)initWithView:(id<UseCasesMockView>)view __attribute__((swift_name("init(view:)"))) __attribute__((objc_designated_initializer));
- (void)setScopeScope:(NSString *)scope __attribute__((swift_name("setScope(scope:)")));
- (void)addMethod:(UseCasesMethod *)method __attribute__((swift_name("add(method:)")));
- (void)addProperty:(UseCasesProperty *)property __attribute__((swift_name("add(property:)")));
- (void)addSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("add(subscript:)")));
- (void)addInitializers:(UseCasesKotlinArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("add(initializers:)")));
- (void)addMethods:(UseCasesKotlinArray<UseCasesMethod *> *)methods __attribute__((swift_name("add(methods:)")));
- (void)addProperties:(UseCasesKotlinArray<UseCasesProperty *> *)properties __attribute__((swift_name("add(properties:)")));
- (void)addSubscripts:(UseCasesKotlinArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("add(subscripts:)")));
- (void)addInitialisersInitializers:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("addInitialisers(initializers:)")));
- (void)addMethodsMethods:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addMethods(methods:)")));
- (void)addPropertiesProperties:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addProperties(properties:)")));
- (void)addSubscriptsSubscripts:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addSubscripts(subscripts:)")));
- (void)setClassInitialisersInitializers:(UseCasesKotlinArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("setClassInitialisers(initializers:)")));
- (void)setClassInitialisersInitializers_:(NSArray<UseCasesInitializer *> *)initializers __attribute__((swift_name("setClassInitialisers(initializers_:)")));
- (void)addClassMethodsMethods:(UseCasesKotlinArray<UseCasesMethod *> *)methods __attribute__((swift_name("addClassMethods(methods:)")));
- (void)addClassMethodsMethods_:(NSArray<UseCasesMethod *> *)methods __attribute__((swift_name("addClassMethods(methods_:)")));
- (void)addClassPropertiesProperties:(UseCasesKotlinArray<UseCasesProperty *> *)properties __attribute__((swift_name("addClassProperties(properties:)")));
- (void)addClassPropertiesProperties_:(NSArray<UseCasesProperty *> *)properties __attribute__((swift_name("addClassProperties(properties_:)")));
- (void)addClassSubscriptsSubscripts:(UseCasesKotlinArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts:)")));
- (void)addClassSubscriptsSubscripts_:(NSArray<UseCasesSubscript *> *)subscripts __attribute__((swift_name("addClassSubscripts(subscripts_:)")));
- (NSString *)generate __attribute__((swift_name("generate()")));
@property (readonly) id<UseCasesMockView> view __attribute__((swift_name("view")));
@end;

__attribute__((swift_name("StringDecorator")))
@interface UseCasesStringDecorator : UseCasesBase
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer));
- (NSString *)processString:(NSString *)string __attribute__((swift_name("process(string:)")));
- (NSString *)decorateString:(NSString *)string __attribute__((swift_name("decorate(string:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("AppendStringDecorator")))
@interface UseCasesAppendStringDecorator : UseCasesStringDecorator
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator suffix:(NSString *)suffix __attribute__((swift_name("init(decorator:suffix:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
- (NSString *)decorateString:(NSString *)string __attribute__((swift_name("decorate(string:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ClosureUtil")))
@interface UseCasesClosureUtil : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesClosureUtilCompanion *companion __attribute__((swift_name("companion")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ClosureUtil.Companion")))
@interface UseCasesClosureUtilCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesClosureUtilCompanion *shared __attribute__((swift_name("shared")));
- (BOOL)isClosureType:(NSString *)type __attribute__((swift_name("isClosure(type:)")));
- (NSString *)surroundClosureType:(NSString *)type __attribute__((swift_name("surroundClosure(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DefaultValueStore")))
@interface UseCasesDefaultValueStore : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (NSString * _Nullable)getDefaultValueTypeName:(NSString *)typeName __attribute__((swift_name("getDefaultValue(typeName:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KeywordsStore")))
@interface UseCasesKeywordsStore : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (BOOL)isSwiftKeywordInput:(NSString *)input __attribute__((swift_name("isSwiftKeyword(input:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MethodModel")))
@interface UseCasesMethodModel : UseCasesBase
- (instancetype)initWithMethodName:(NSString *)methodName paramLabels:(UseCasesKotlinArray<NSString *> *)paramLabels __attribute__((swift_name("init(methodName:paramLabels:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMethodName:(NSString *)methodName paramLabels_:(NSArray<UseCasesParameter *> *)paramLabels __attribute__((swift_name("init(methodName:paramLabels_:)"))) __attribute__((objc_designated_initializer));
- (NSString * _Nullable)nextPreferredName __attribute__((swift_name("nextPreferredName()")));
- (NSString * _Nullable)peekNextPreferredName __attribute__((swift_name("peekNextPreferredName()")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) int32_t parameterCount __attribute__((swift_name("parameterCount")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ParameterUtil")))
@interface UseCasesParameterUtil : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesParameterUtilCompanion *companion __attribute__((swift_name("companion")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ParameterUtil.Companion")))
@interface UseCasesParameterUtilCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesParameterUtilCompanion *shared __attribute__((swift_name("shared")));
- (NSArray<NSString *> *)getParameterListParameters:(NSString *)parameters __attribute__((swift_name("getParameterList(parameters:)")));
- (NSArray<UseCasesParameter *> *)getParametersParameters:(NSString *)parameters __attribute__((swift_name("getParameters(parameters:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("PrependStringDecorator")))
@interface UseCasesPrependStringDecorator : UseCasesStringDecorator
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator prefix:(NSString *)prefix __attribute__((swift_name("init(decorator:prefix:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithDecorator:(UseCasesStringDecorator * _Nullable)decorator __attribute__((swift_name("init(decorator:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
- (NSString *)decorateString:(NSString *)string __attribute__((swift_name("decorate(string:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UniqueMethodNameGenerator")))
@interface UseCasesUniqueMethodNameGenerator : UseCasesBase
- (instancetype)initWithMethodModels:(UseCasesKotlinArray<UseCasesMethodModel *> *)methodModels __attribute__((swift_name("init(methodModels:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMethodModels_:(NSArray<UseCasesMethodModel *> *)methodModels __attribute__((swift_name("init(methodModels_:)"))) __attribute__((objc_designated_initializer));
- (void)generateMethodNames __attribute__((swift_name("generateMethodNames()")));
- (NSString * _Nullable)getMethodNameId:(NSString *)id __attribute__((swift_name("getMethodName(id:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CreateConvenienceInitialiser")))
@interface UseCasesCreateConvenienceInitialiser : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesInitialiserCall * _Nullable)transformInitializer:(UseCasesInitializer *)initializer __attribute__((swift_name("transform(initializer:)")));
@end;

__attribute__((swift_name("CreateParameterTuple")))
@interface UseCasesCreateParameterTuple : UseCasesBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesStringDecorator *)getStringDecorator __attribute__((swift_name("getStringDecorator()")));
- (UseCasesTuplePropertyDeclaration * _Nullable)transformParameterList:(NSArray<UseCasesParameter *> *)parameterList genericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("transform(parameterList:genericIdentifiers:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CreateInvokedParameters")))
@interface UseCasesCreateInvokedParameters : UseCasesCreateParameterTuple
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (UseCasesStringDecorator *)getStringDecorator __attribute__((swift_name("getStringDecorator()")));
@end;

__attribute__((swift_name("Visitor")))
@interface UseCasesVisitor : UseCasesBase
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
__attribute__((swift_name("CopyVisitor")))
@interface UseCasesCopyVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesCopyVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitTypeIdentifierType:(UseCasesTypeIdentifier *)type __attribute__((swift_name("visitTypeIdentifier(type:)")));
- (void)visitFunctionTypeType:(UseCasesFunctionType *)type __attribute__((swift_name("visitFunctionType(type:)")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
- (void)visitTupleTypeType:(UseCasesTupleType *)type __attribute__((swift_name("visitTupleType(type:)")));
- (void)visitArrayTypeType:(UseCasesArrayType *)type __attribute__((swift_name("visitArrayType(type:)")));
- (void)visitDictionaryTypeType:(UseCasesDictionaryType *)type __attribute__((swift_name("visitDictionaryType(type:)")));
- (void)visitGenericTypeType:(UseCasesGenericType *)type __attribute__((swift_name("visitGenericType(type:)")));
@property (getter=doCopy) id<UseCasesType> copy __attribute__((swift_name("copy")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CopyVisitor.Companion")))
@interface UseCasesCopyVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesCopyVisitorCompanion *shared __attribute__((swift_name("shared")));
- (id<UseCasesType>)doCopyType:(id<UseCasesType>)type __attribute__((swift_name("doCopy(type:)")));
- (NSArray<id<UseCasesType>> *)doCopyTypes:(NSArray<id<UseCasesType>> *)types __attribute__((swift_name("doCopy(types:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DefaultValueVisitor")))
@interface UseCasesDefaultValueVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesDefaultValueVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitTypeIdentifierType:(UseCasesTypeIdentifier *)type __attribute__((swift_name("visitTypeIdentifier(type:)")));
- (void)visitFunctionTypeType:(UseCasesFunctionType *)type __attribute__((swift_name("visitFunctionType(type:)")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
- (void)visitTupleTypeType:(UseCasesTupleType *)type __attribute__((swift_name("visitTupleType(type:)")));
- (void)visitArrayTypeType:(UseCasesArrayType *)type __attribute__((swift_name("visitArrayType(type:)")));
- (void)visitDictionaryTypeType:(UseCasesDictionaryType *)type __attribute__((swift_name("visitDictionaryType(type:)")));
- (void)visitGenericTypeType:(UseCasesGenericType *)type __attribute__((swift_name("visitGenericType(type:)")));
@property NSString * _Nullable defaultValue __attribute__((swift_name("defaultValue")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DefaultValueVisitor.Companion")))
@interface UseCasesDefaultValueVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesDefaultValueVisitorCompanion *shared __attribute__((swift_name("shared")));
- (NSString * _Nullable)getDefaultValueElement:(id<UseCasesElement>)element __attribute__((swift_name("getDefaultValue(element:)")));
@end;

__attribute__((swift_name("RecursiveVisitor")))
@interface UseCasesRecursiveVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
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
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("FunctionParameterTransformer")))
@interface UseCasesFunctionParameterTransformer : UseCasesRecursiveVisitor
- (instancetype)initWithName:(NSString *)name __attribute__((swift_name("init(name:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
- (void)visitFunctionTypeType:(UseCasesFunctionType *)type __attribute__((swift_name("visitFunctionType(type:)")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
@property UseCasesClosureParameterViewModel * _Nullable transformed __attribute__((swift_name("transformed")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MakeFunctionCallVisitor")))
@interface UseCasesMakeFunctionCallVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesMakeFunctionCallVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitMethodDeclaration:(UseCasesMethod *)declaration __attribute__((swift_name("visitMethod(declaration:)")));
- (void)visitSubscriptSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("visitSubscript(subscript:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MakeFunctionCallVisitor.Companion")))
@interface UseCasesMakeFunctionCallVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesMakeFunctionCallVisitorCompanion *shared __attribute__((swift_name("shared")));
- (NSString * _Nullable)makeElement:(id<UseCasesElement>)element __attribute__((swift_name("make(element:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("OptionalizeIUOVisitor")))
@interface UseCasesOptionalizeIUOVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesOptionalizeIUOVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("OptionalizeIUOVisitor.Companion")))
@interface UseCasesOptionalizeIUOVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesOptionalizeIUOVisitorCompanion *shared __attribute__((swift_name("shared")));
- (id<UseCasesType>)optionalizeType:(id<UseCasesType>)type __attribute__((swift_name("optionalize(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RecursiveRemoveOptionalVisitor")))
@interface UseCasesRecursiveRemoveOptionalVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesRecursiveRemoveOptionalVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RecursiveRemoveOptionalVisitor.Companion")))
@interface UseCasesRecursiveRemoveOptionalVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesRecursiveRemoveOptionalVisitorCompanion *shared __attribute__((swift_name("shared")));
- (id<UseCasesType>)removeOptionalType:(id<UseCasesType>)type __attribute__((swift_name("removeOptional(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RemoveOptionalVisitor")))
@interface UseCasesRemoveOptionalVisitor : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesRemoveOptionalVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitOptionalTypeType:(UseCasesOptionalType *)type __attribute__((swift_name("visitOptionalType(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RemoveOptionalVisitor.Companion")))
@interface UseCasesRemoveOptionalVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesRemoveOptionalVisitorCompanion *shared __attribute__((swift_name("shared")));
- (id<UseCasesType>)removeOptionalType:(id<UseCasesType>)type __attribute__((swift_name("removeOptional(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SignatureGenerator")))
@interface UseCasesSignatureGenerator : UseCasesVisitor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (class, readonly, getter=companion) UseCasesSignatureGeneratorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitInitializerDeclaration:(UseCasesInitializer *)declaration __attribute__((swift_name("visitInitializer(declaration:)")));
- (void)visitPropertyDeclaration:(UseCasesProperty *)declaration __attribute__((swift_name("visitProperty(declaration:)")));
- (void)visitMethodDeclaration:(UseCasesMethod *)declaration __attribute__((swift_name("visitMethod(declaration:)")));
- (void)visitSubscriptSubscript:(UseCasesSubscript *)subscript __attribute__((swift_name("visitSubscript(subscript:)")));
- (void)visitParameterParameter:(UseCasesParameter *)parameter __attribute__((swift_name("visitParameter(parameter:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SignatureGenerator.Companion")))
@interface UseCasesSignatureGeneratorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesSignatureGeneratorCompanion *shared __attribute__((swift_name("shared")));
- (NSString *)signatureElement:(id<UseCasesElement>)element __attribute__((swift_name("signature(element:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SurroundOptionalVisitor")))
@interface UseCasesSurroundOptionalVisitor : UseCasesVisitor
- (instancetype)initWithUnwrapped:(BOOL)unwrapped __attribute__((swift_name("init(unwrapped:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@property (class, readonly, getter=companion) UseCasesSurroundOptionalVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitTypeType:(id<UseCasesType>)type __attribute__((swift_name("visitType(type:)")));
- (void)visitFunctionTypeType:(UseCasesFunctionType *)type __attribute__((swift_name("visitFunctionType(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SurroundOptionalVisitor.Companion")))
@interface UseCasesSurroundOptionalVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesSurroundOptionalVisitorCompanion *shared __attribute__((swift_name("shared")));
- (id<UseCasesType>)surroundType:(id<UseCasesType>)type unwrapped:(BOOL)unwrapped __attribute__((swift_name("surround(type:unwrapped:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeErasingVisitor")))
@interface UseCasesTypeErasingVisitor : UseCasesRecursiveVisitor
- (instancetype)initWithGenericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("init(genericIdentifiers:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@property (class, readonly, getter=companion) UseCasesTypeErasingVisitorCompanion *companion __attribute__((swift_name("companion")));
- (void)visitTypeIdentifierType:(UseCasesTypeIdentifier *)type __attribute__((swift_name("visitTypeIdentifier(type:)")));
- (void)visitDictionaryTypeType:(UseCasesDictionaryType *)type __attribute__((swift_name("visitDictionaryType(type:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TypeErasingVisitor.Companion")))
@interface UseCasesTypeErasingVisitorCompanion : UseCasesBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) UseCasesTypeErasingVisitorCompanion *shared __attribute__((swift_name("shared")));
- (void)eraseType:(id<UseCasesType>)type genericIdentifiers:(NSArray<NSString *> *)genericIdentifiers __attribute__((swift_name("erase(type:genericIdentifiers:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinArray")))
@interface UseCasesKotlinArray<T> : UseCasesBase
+ (instancetype)arrayWithSize:(int32_t)size init:(T _Nullable (^)(UseCasesInt *))init __attribute__((swift_name("init(size:init:)")));
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (T _Nullable)getIndex:(int32_t)index __attribute__((swift_name("get(index:)")));
- (id<UseCasesKotlinIterator>)iterator __attribute__((swift_name("iterator()")));
- (void)setIndex:(int32_t)index value:(T _Nullable)value __attribute__((swift_name("set(index:value:)")));
@property (readonly) int32_t size __attribute__((swift_name("size")));
@end;

__attribute__((swift_name("KotlinIterator")))
@protocol UseCasesKotlinIterator
@required
- (BOOL)hasNext __attribute__((swift_name("hasNext()")));
- (id _Nullable)next __attribute__((swift_name("next()")));
@end;

#pragma pop_macro("_Nullable_result")
#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
