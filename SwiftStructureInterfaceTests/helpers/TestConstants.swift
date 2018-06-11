@testable import SwiftStructureInterface

let emptyTypeDeclaration = TypeDeclarationImpl(name: "", text: "", children: [], inheritedTypes: [], offset: 0, length: 0, bodyOffset: 0, bodyLength: 0, accessLevelModifier: AccessLevelModifierImpl.emptyAccessLevelModifier)
let emptyElement = ElementImpl(text: "", children: [], offset: 0, length: 0)
let emptyFile = FileImpl(text: "", children: [], offset: 0, length: 0)
let emptyFunctionDeclaration = FunctionDeclarationImpl(name: "", text: "", children: [], offset: 0, length: 0, returnType: nil, parameters: [])
let emptyVariableDeclaration = VariableDeclarationImpl(name: "", text: "", children: [], offset: 0, length: 0, type: testType, isWritable: false)

let testFunctionParameter = ParameterImpl(text: "a: Int", children: [testType], offset: 0, length: 6, externalParameterName: nil, localParameterName: "a", typeAnnotation: testTypeAnnotation)
let testInitialiserDeclaration = FileParser(fileContents: "init()").parseInitialiserDeclaration()
