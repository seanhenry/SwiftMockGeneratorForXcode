@testable import TestProject

class InferredTypeClassMock: InferredTypeClass {
    var invokedFromInitializerSetter = false
    var invokedFromInitializerSetterCount = 0
    var invokedFromInitializer: HelperClass?
    var invokedFromInitializerList = [HelperClass]()
    var invokedFromInitializerGetter = false
    var invokedFromInitializerGetterCount = 0
    var stubbedFromInitializer: HelperClass!
    override var fromInitializer: HelperClass {
        set {
            invokedFromInitializerSetter = true
            invokedFromInitializerSetterCount += 1
            invokedFromInitializer = newValue
            invokedFromInitializerList.append(newValue)
        }
        get {
            invokedFromInitializerGetter = true
            invokedFromInitializerGetterCount += 1
            return stubbedFromInitializer
        }
    }
    var invokedStringLiteralSetter = false
    var invokedStringLiteralSetterCount = 0
    var invokedStringLiteral: String?
    var invokedStringLiteralList = [String]()
    var invokedStringLiteralGetter = false
    var invokedStringLiteralGetterCount = 0
    var stubbedStringLiteral: String! = ""
    override var stringLiteral: String {
        set {
            invokedStringLiteralSetter = true
            invokedStringLiteralSetterCount += 1
            invokedStringLiteral = newValue
            invokedStringLiteralList.append(newValue)
        }
        get {
            invokedStringLiteralGetter = true
            invokedStringLiteralGetterCount += 1
            return stubbedStringLiteral
        }
    }
    var invokedDictionaryLiteralSetter = false
    var invokedDictionaryLiteralSetterCount = 0
    var invokedDictionaryLiteral: [HelperClass: HelperClass]?
    var invokedDictionaryLiteralList = [[HelperClass: HelperClass]]()
    var invokedDictionaryLiteralGetter = false
    var invokedDictionaryLiteralGetterCount = 0
    var stubbedDictionaryLiteral: [HelperClass: HelperClass]! = [:]
    override var dictionaryLiteral: [HelperClass: HelperClass] {
        set {
            invokedDictionaryLiteralSetter = true
            invokedDictionaryLiteralSetterCount += 1
            invokedDictionaryLiteral = newValue
            invokedDictionaryLiteralList.append(newValue)
        }
        get {
            invokedDictionaryLiteralGetter = true
            invokedDictionaryLiteralGetterCount += 1
            return stubbedDictionaryLiteral
        }
    }
    var invokedDictionaryLiteral2Setter = false
    var invokedDictionaryLiteral2SetterCount = 0
    var invokedDictionaryLiteral2: [String: Int]?
    var invokedDictionaryLiteral2List = [[String: Int]]()
    var invokedDictionaryLiteral2Getter = false
    var invokedDictionaryLiteral2GetterCount = 0
    var stubbedDictionaryLiteral2: [String: Int]! = [:]
    override var dictionaryLiteral2: [String: Int] {
        set {
            invokedDictionaryLiteral2Setter = true
            invokedDictionaryLiteral2SetterCount += 1
            invokedDictionaryLiteral2 = newValue
            invokedDictionaryLiteral2List.append(newValue)
        }
        get {
            invokedDictionaryLiteral2Getter = true
            invokedDictionaryLiteral2GetterCount += 1
            return stubbedDictionaryLiteral2
        }
    }
    var invokedArrayLiteralSetter = false
    var invokedArrayLiteralSetterCount = 0
    var invokedArrayLiteral: [HelperClass]?
    var invokedArrayLiteralList = [[HelperClass]]()
    var invokedArrayLiteralGetter = false
    var invokedArrayLiteralGetterCount = 0
    var stubbedArrayLiteral: [HelperClass]! = []
    override var arrayLiteral: [HelperClass] {
        set {
            invokedArrayLiteralSetter = true
            invokedArrayLiteralSetterCount += 1
            invokedArrayLiteral = newValue
            invokedArrayLiteralList.append(newValue)
        }
        get {
            invokedArrayLiteralGetter = true
            invokedArrayLiteralGetterCount += 1
            return stubbedArrayLiteral
        }
    }
    var invokedArrayLiteral2Setter = false
    var invokedArrayLiteral2SetterCount = 0
    var invokedArrayLiteral2: [Int]?
    var invokedArrayLiteral2List = [[Int]]()
    var invokedArrayLiteral2Getter = false
    var invokedArrayLiteral2GetterCount = 0
    var stubbedArrayLiteral2: [Int]! = []
    override var arrayLiteral2: [Int] {
        set {
            invokedArrayLiteral2Setter = true
            invokedArrayLiteral2SetterCount += 1
            invokedArrayLiteral2 = newValue
            invokedArrayLiteral2List.append(newValue)
        }
        get {
            invokedArrayLiteral2Getter = true
            invokedArrayLiteral2GetterCount += 1
            return stubbedArrayLiteral2
        }
    }
    var invokedAsExpressionSetter = false
    var invokedAsExpressionSetterCount = 0
    var invokedAsExpression: [Any]?
    var invokedAsExpressionList = [[Any]]()
    var invokedAsExpressionGetter = false
    var invokedAsExpressionGetterCount = 0
    var stubbedAsExpression: [Any]! = []
    override var asExpression: [Any] {
        set {
            invokedAsExpressionSetter = true
            invokedAsExpressionSetterCount += 1
            invokedAsExpression = newValue
            invokedAsExpressionList.append(newValue)
        }
        get {
            invokedAsExpressionGetter = true
            invokedAsExpressionGetterCount += 1
            return stubbedAsExpression
        }
    }
    var invokedIsExpressionSetter = false
    var invokedIsExpressionSetterCount = 0
    var invokedIsExpression: Bool?
    var invokedIsExpressionList = [Bool]()
    var invokedIsExpressionGetter = false
    var invokedIsExpressionGetterCount = 0
    var stubbedIsExpression: Bool! = false
    override var isExpression: Bool {
        set {
            invokedIsExpressionSetter = true
            invokedIsExpressionSetterCount += 1
            invokedIsExpression = newValue
            invokedIsExpressionList.append(newValue)
        }
        get {
            invokedIsExpressionGetter = true
            invokedIsExpressionGetterCount += 1
            return stubbedIsExpression
        }
    }
    var invokedTupleSetter = false
    var invokedTupleSetterCount = 0
    var invokedTuple: (Int, String)?
    var invokedTupleList = [(Int, String)]()
    var invokedTupleGetter = false
    var invokedTupleGetterCount = 0
    var stubbedTuple: (Int, String)! = (0, "")
    override var tuple: (Int, String) {
        set {
            invokedTupleSetter = true
            invokedTupleSetterCount += 1
            invokedTuple = newValue
            invokedTupleList.append(newValue)
        }
        get {
            invokedTupleGetter = true
            invokedTupleGetterCount += 1
            return stubbedTuple
        }
    }
    var invokedMethodAssignedSetter = false
    var invokedMethodAssignedSetterCount = 0
    var invokedMethodAssigned: String?
    var invokedMethodAssignedList = [String]()
    var invokedMethodAssignedGetter = false
    var invokedMethodAssignedGetterCount = 0
    var stubbedMethodAssigned: String! = ""
    override var methodAssigned: String {
        set {
            invokedMethodAssignedSetter = true
            invokedMethodAssignedSetterCount += 1
            invokedMethodAssigned = newValue
            invokedMethodAssignedList.append(newValue)
        }
        get {
            invokedMethodAssignedGetter = true
            invokedMethodAssignedGetterCount += 1
            return stubbedMethodAssigned
        }
    }
    var invokedPropertyAssignedSetter = false
    var invokedPropertyAssignedSetterCount = 0
    var invokedPropertyAssigned: String?
    var invokedPropertyAssignedList = [String]()
    var invokedPropertyAssignedGetter = false
    var invokedPropertyAssignedGetterCount = 0
    var stubbedPropertyAssigned: String! = ""
    override var propertyAssigned: String {
        set {
            invokedPropertyAssignedSetter = true
            invokedPropertyAssignedSetterCount += 1
            invokedPropertyAssigned = newValue
            invokedPropertyAssignedList.append(newValue)
        }
        get {
            invokedPropertyAssignedGetter = true
            invokedPropertyAssignedGetterCount += 1
            return stubbedPropertyAssigned
        }
    }
}
