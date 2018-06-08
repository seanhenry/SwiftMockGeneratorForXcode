@testable import SwiftStructureInterface

let emptyTypeDeclaration = TypeDeclarationImpl(name: "", text: "", children: [], inheritedTypes: [], offset: 0, length: 0, bodyOffset: 0, bodyLength: 0, accessLevelModifier: testAccessLevelModifier)
let emptyElement = ElementImpl(text: "", children: [], offset: 0, length: 0)
let emptyFile = FileImpl(text: "", children: [], offset: 0, length: 0)
let emptyFunctionDeclaration = FunctionDeclarationImpl(name: "", text: "", children: [], offset: 0, length: 0, returnType: nil, parameters: [])
let emptyVariableDeclaration = VariableDeclarationImpl(name: "", text: "", children: [], offset: 0, length: 0, type: testType, isWritable: false)

let testType = SwiftType(text: "Int", children: [], offset: 0, length: 3)
let testTypealiasAssignment = TypealiasAssignmentImpl(text: "= Type", children: [testType], offset: 0, length: 6, type: testType)
let testTypealias = TypealiasImpl(text: "Int", children: [], offset: 0, length: 3, name: "Type", typealiasAssignment: testTypealiasAssignment)
let testGenericParameterClause = FileParser(fileContents: "<T>").parseGenericParameterClause()
let testGenericParameter = testGenericParameterClause.parameters[0]
let testFunctionDeclaration = FunctionDeclarationImpl(name: "myMethod", text: "func myMethod()", children: [], offset: 0, length: 15, returnType: nil, genericParameterClause: testGenericParameterClause, parameters: [], throws: false)
let testFunctionParameter = ParameterImpl(text: "a: Int", children: [testType], offset: 0, length: 6, externalParameterName: nil, localParameterName: "a", typeAnnotation: testTypeAnnotation)
let testArrayType = SwiftArrayType(text: "[Int]", children: [], offset: 0, length: 5, elementType: testType)
let testDictionaryType = SwiftDictionaryType(text: "[Int: Int]", children: [], offset: 0, length: 10, keyType: testType, valueType: testType)
let testOptionalType = SwiftOptionalType(text: "[Int: Int]", children: [], offset: 0, length: 10, type: testType)
let testInitialiserDeclaration = FileParser(fileContents: "init()").parseInitialiserDeclaration()
let testSubscriptDeclaration = SubscriptDeclarationImpl(text: "init()", children: [], offset: 0, length: 6)
let testTypeIdentifier = SwiftTypeIdentifier(text: "Int", children: [], offset: 0, length: 3, typeName: "Int", genericArguments: [], parentType: nil)
let testTupleType = FileParser(fileContents: "(Int)").parseType() as! TupleType
let testTupleTypeElement = testTupleType.elements[0]
let testTypeAnnotation = testTupleTypeElement.typeAnnotation
let testFunctionType = FileParser(fileContents: "() -> ()").parseType() as! FunctionType
let testAccessLevelModifier = FileParser(fileContents: "").parseAccessLevelModifier()
