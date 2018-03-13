@testable import SwiftStructureInterface

let emptyTypeDeclaration = SwiftTypeElement(name: "", text: "", children: [], inheritedTypes: [], offset: 0, length: 0, bodyOffset: 0, bodyLength: 0)
let emptyElement = SwiftElement(text: "", children: [], offset: 0, length: 0)
let emptyFile = SwiftFile(text: "", children: [], offset: 0, length: 0)
let emptyFunctionDeclaration = SwiftFunctionDeclaration(name: "", text: "", children: [], offset: 0, length: 0, returnType: nil, parameters: [])
let emptyVariableDeclaration = SwiftVariableDeclaration(name: "", text: "", children: [], offset: 0, length: 0, type: testType, isWritable: false)

let testType = SwiftType(text: "Int", children: [], offset: 0, length: 3)
let testTypealiasAssignment = SwiftTypealiasAssignment(text: "= Type", children: [testType], offset: 0, length: 6, type: testType)
let testTypealias = SwiftTypealias(text: "Int", children: [], offset: 0, length: 3, name: "Type", typealiasAssignment: testTypealiasAssignment)
let testGenericParameterClause = SwiftGenericParameterClause(text: "<T>", children: [], offset: 0, length: 3)
let testFunctionDeclaration = SwiftFunctionDeclaration(name: "myMethod", text: "func myMethod()", children: [], offset: 0, length: 15, returnType: nil, genericParameterClause: testGenericParameterClause, parameters: [], throws: false)
let testFunctionParameter = SwiftParameter(text: "a: Int", children: [testType], offset: 0, length: 6, externalParameterName: nil, localParameterName: "a", type: testType)
let testArrayType = SwiftArrayType(text: "[Int]", children: [], offset: 0, length: 5, elementType: testType)
let testDictionaryType = SwiftDictionaryType(text: "[Int: Int]", children: [], offset: 0, length: 10, keyType: testType, valueType: testType)
