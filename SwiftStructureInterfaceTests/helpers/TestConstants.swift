@testable import SwiftStructureInterface

let emptySwiftTypeElement = SwiftTypeElement(name: "", text: "", children: [], inheritedTypes: [], offset: 0, length: 0, bodyOffset: 0, bodyLength: 0)
let emptySwiftElement = SwiftElement(name: "", text: "", children: [], offset: 0, length: 0)
let emptySwiftFile = SwiftFile(name: "", text: "", children: [], offset: 0, length: 0)
let emptySwiftMethod = SwiftMethodElement(name: "", text: "", children: [], offset: 0, length: 0, returnType: nil)
let emptySwiftProperty = SwiftPropertyElement(name: "", text: "", children: [], offset: 0, length: 0, type: "", isWritable: false, attribute: nil)
