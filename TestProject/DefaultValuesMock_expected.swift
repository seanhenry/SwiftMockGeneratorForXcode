@testable import TestProject

class DefaultValuesMock: DefaultValues {

    var invokedIntSetter = false
    var invokedIntSetterCount = 0
    var invokedInt: Int?
    var invokedIntList = [Int]()
    var invokedIntGetter = false
    var invokedIntGetterCount = 0
    var stubbedInt: Int! = 0

    var int: Int {
        set {
            invokedIntSetter = true
            invokedIntSetterCount += 1
            invokedInt = newValue
            invokedIntList.append(newValue)
        }
        get {
            invokedIntGetter = true
            invokedIntGetterCount += 1
            return stubbedInt
        }
    }

    var invokedOptSetter = false
    var invokedOptSetterCount = 0
    var invokedOpt: Optional<Int>?
    var invokedOptList = [Optional<Int>]()
    var invokedOptGetter = false
    var invokedOptGetterCount = 0
    var stubbedOpt: Optional<Int>!

    var opt: Optional<Int> {
        set {
            invokedOptSetter = true
            invokedOptSetterCount += 1
            invokedOpt = newValue
            invokedOptList.append(newValue)
        }
        get {
            invokedOptGetter = true
            invokedOptGetterCount += 1
            return stubbedOpt
        }
    }

    var invokedShortOptionalSetter = false
    var invokedShortOptionalSetterCount = 0
    var invokedShortOptional: Int?
    var invokedShortOptionalList = [Int?]()
    var invokedShortOptionalGetter = false
    var invokedShortOptionalGetterCount = 0
    var stubbedShortOptional: Int!

    var shortOptional: Int? {
        set {
            invokedShortOptionalSetter = true
            invokedShortOptionalSetterCount += 1
            invokedShortOptional = newValue
            invokedShortOptionalList.append(newValue)
        }
        get {
            invokedShortOptionalGetter = true
            invokedShortOptionalGetterCount += 1
            return stubbedShortOptional
        }
    }

    var invokedDoubleOptionalSetter = false
    var invokedDoubleOptionalSetterCount = 0
    var invokedDoubleOptional: Int??
    var invokedDoubleOptionalList = [Int??]()
    var invokedDoubleOptionalGetter = false
    var invokedDoubleOptionalGetterCount = 0
    var stubbedDoubleOptional: Int!

    var doubleOptional: Int?? {
        set {
            invokedDoubleOptionalSetter = true
            invokedDoubleOptionalSetterCount += 1
            invokedDoubleOptional = newValue
            invokedDoubleOptionalList.append(newValue)
        }
        get {
            invokedDoubleOptionalGetter = true
            invokedDoubleOptionalGetterCount += 1
            return stubbedDoubleOptional
        }
    }

    var invokedIuoSetter = false
    var invokedIuoSetterCount = 0
    var invokedIuo: Int?
    var invokedIuoList = [Int?]()
    var invokedIuoGetter = false
    var invokedIuoGetterCount = 0
    var stubbedIuo: Int!

    var iuo: Int! {
        set {
            invokedIuoSetter = true
            invokedIuoSetterCount += 1
            invokedIuo = newValue
            invokedIuoList.append(newValue)
        }
        get {
            invokedIuoGetter = true
            invokedIuoGetterCount += 1
            return stubbedIuo
        }
    }

    var invokedOptionalInt = false
    var invokedOptionalIntCount = 0
    var stubbedOptionalIntResult: Int!

    func optionalInt() -> Int? {
        invokedOptionalInt = true
        invokedOptionalIntCount += 1
        return stubbedOptionalIntResult
    }

    var invokedIuoInt = false
    var invokedIuoIntCount = 0
    var stubbedIuoIntResult: Int!

    func iuoInt() -> Int! {
        invokedIuoInt = true
        invokedIuoIntCount += 1
        return stubbedIuoIntResult
    }

    var invokedDouble = false
    var invokedDoubleCount = 0
    var stubbedDoubleResult: Double! = 0

    func double() -> Double {
        invokedDouble = true
        invokedDoubleCount += 1
        return stubbedDoubleResult
    }

    var invokedFloat = false
    var invokedFloatCount = 0
    var stubbedFloatResult: Float! = 0

    func float() -> Float {
        invokedFloat = true
        invokedFloatCount += 1
        return stubbedFloatResult
    }

    var invokedInt16 = false
    var invokedInt16Count = 0
    var stubbedInt16Result: Int16! = 0

    func int16() -> Int16 {
        invokedInt16 = true
        invokedInt16Count += 1
        return stubbedInt16Result
    }

    var invokedInt32 = false
    var invokedInt32Count = 0
    var stubbedInt32Result: Int32! = 0

    func int32() -> Int32 {
        invokedInt32 = true
        invokedInt32Count += 1
        return stubbedInt32Result
    }

    var invokedInt64 = false
    var invokedInt64Count = 0
    var stubbedInt64Result: Int64! = 0

    func int64() -> Int64 {
        invokedInt64 = true
        invokedInt64Count += 1
        return stubbedInt64Result
    }

    var invokedInt8 = false
    var invokedInt8Count = 0
    var stubbedInt8Result: Int8! = 0

    func int8() -> Int8 {
        invokedInt8 = true
        invokedInt8Count += 1
        return stubbedInt8Result
    }

    var invokedUInt = false
    var invokedUIntCount = 0
    var stubbedUIntResult: UInt! = 0

    func uInt() -> UInt {
        invokedUInt = true
        invokedUIntCount += 1
        return stubbedUIntResult
    }

    var invokedUInt16 = false
    var invokedUInt16Count = 0
    var stubbedUInt16Result: UInt16! = 0

    func uInt16() -> UInt16 {
        invokedUInt16 = true
        invokedUInt16Count += 1
        return stubbedUInt16Result
    }

    var invokedUInt32 = false
    var invokedUInt32Count = 0
    var stubbedUInt32Result: UInt32! = 0

    func uInt32() -> UInt32 {
        invokedUInt32 = true
        invokedUInt32Count += 1
        return stubbedUInt32Result
    }

    var invokedUInt64 = false
    var invokedUInt64Count = 0
    var stubbedUInt64Result: UInt64! = 0

    func uInt64() -> UInt64 {
        invokedUInt64 = true
        invokedUInt64Count += 1
        return stubbedUInt64Result
    }

    var invokedUInt8 = false
    var invokedUInt8Count = 0
    var stubbedUInt8Result: UInt8! = 0

    func uInt8() -> UInt8 {
        invokedUInt8 = true
        invokedUInt8Count += 1
        return stubbedUInt8Result
    }

    var invokedArray = false
    var invokedArrayCount = 0
    var stubbedArrayResult: Array<String>! = []

    func array() -> Array<String> {
        invokedArray = true
        invokedArrayCount += 1
        return stubbedArrayResult
    }

    var invokedArrayLiteral = false
    var invokedArrayLiteralCount = 0
    var stubbedArrayLiteralResult: [String]! = []

    func arrayLiteral() -> [String] {
        invokedArrayLiteral = true
        invokedArrayLiteralCount += 1
        return stubbedArrayLiteralResult
    }

    var invokedArraySlice = false
    var invokedArraySliceCount = 0
    var stubbedArraySliceResult: ArraySlice<String>! = []

    func arraySlice() -> ArraySlice<String> {
        invokedArraySlice = true
        invokedArraySliceCount += 1
        return stubbedArraySliceResult
    }

    var invokedContiguousArray = false
    var invokedContiguousArrayCount = 0
    var stubbedContiguousArrayResult: ContiguousArray<String>! = []

    func contiguousArray() -> ContiguousArray<String> {
        invokedContiguousArray = true
        invokedContiguousArrayCount += 1
        return stubbedContiguousArrayResult
    }

    var invokedSet = false
    var invokedSetCount = 0
    var stubbedSetResult: Set<String>! = []

    func set() -> Set<String> {
        invokedSet = true
        invokedSetCount += 1
        return stubbedSetResult
    }

    var invokedOptionalArray = false
    var invokedOptionalArrayCount = 0
    var stubbedOptionalArrayResult: Optional<Array<String>>!

    func optionalArray() -> Optional<Array<String>> {
        invokedOptionalArray = true
        invokedOptionalArrayCount += 1
        return stubbedOptionalArrayResult
    }

    var invokedShortOptionalArray = false
    var invokedShortOptionalArrayCount = 0
    var stubbedShortOptionalArrayResult: [String]!

    func shortOptionalArray() -> [String]? {
        invokedShortOptionalArray = true
        invokedShortOptionalArrayCount += 1
        return stubbedShortOptionalArrayResult
    }

    var invokedDictionary = false
    var invokedDictionaryCount = 0
    var stubbedDictionaryResult: Dictionary<String, String>! = [:]

    func dictionary() -> Dictionary<String, String> {
        invokedDictionary = true
        invokedDictionaryCount += 1
        return stubbedDictionaryResult
    }

    var invokedDictionaryLiteral = false
    var invokedDictionaryLiteralCount = 0
    var stubbedDictionaryLiteralResult: DictionaryLiteral<String, String>! = [:]

    func dictionaryLiteral() -> DictionaryLiteral<String, String> {
        invokedDictionaryLiteral = true
        invokedDictionaryLiteralCount += 1
        return stubbedDictionaryLiteralResult
    }

    var invokedDictionaryShorthand = false
    var invokedDictionaryShorthandCount = 0
    var stubbedDictionaryShorthandResult: [String: String]! = [:]

    func dictionaryShorthand() -> [String: String] {
        invokedDictionaryShorthand = true
        invokedDictionaryShorthandCount += 1
        return stubbedDictionaryShorthandResult
    }

    var invokedOptionalDict = false
    var invokedOptionalDictCount = 0
    var stubbedOptionalDictResult: Optional<Dictionary<String, String>>!

    func optionalDict() -> Optional<Dictionary<String, String>> {
        invokedOptionalDict = true
        invokedOptionalDictCount += 1
        return stubbedOptionalDictResult
    }

    var invokedShortOptionalDict = false
    var invokedShortOptionalDictCount = 0
    var stubbedShortOptionalDictResult: [String: String]!

    func shortOptionalDict() -> [String: String]? {
        invokedShortOptionalDict = true
        invokedShortOptionalDictCount += 1
        return stubbedShortOptionalDictResult
    }

    var invokedBool = false
    var invokedBoolCount = 0
    var stubbedBoolResult: Bool! = false

    func bool() -> Bool {
        invokedBool = true
        invokedBoolCount += 1
        return stubbedBoolResult
    }

    var invokedUnicodeScalar = false
    var invokedUnicodeScalarCount = 0
    var stubbedUnicodeScalarResult: UnicodeScalar! = "!"

    func unicodeScalar() -> UnicodeScalar {
        invokedUnicodeScalar = true
        invokedUnicodeScalarCount += 1
        return stubbedUnicodeScalarResult
    }

    var invokedCharacter = false
    var invokedCharacterCount = 0
    var stubbedCharacterResult: Character! = "!"

    func character() -> Character {
        invokedCharacter = true
        invokedCharacterCount += 1
        return stubbedCharacterResult
    }

    var invokedStaticString = false
    var invokedStaticStringCount = 0
    var stubbedStaticStringResult: StaticString! = ""

    func staticString() -> StaticString {
        invokedStaticString = true
        invokedStaticStringCount += 1
        return stubbedStaticStringResult
    }

    var invokedString = false
    var invokedStringCount = 0
    var stubbedStringResult: String! = ""

    func string() -> String {
        invokedString = true
        invokedStringCount += 1
        return stubbedStringResult
    }

    var invokedClosureA = false
    var invokedClosureACount = 0
    var stubbedClosureAResult: (() -> ())! = {}

    func closureA() -> () -> () {
        invokedClosureA = true
        invokedClosureACount += 1
        return stubbedClosureAResult
    }

    var invokedClosureB = false
    var invokedClosureBCount = 0
    var stubbedClosureBResult: (() -> (Void))! = {}

    func closureB() -> () -> (Void) {
        invokedClosureB = true
        invokedClosureBCount += 1
        return stubbedClosureBResult
    }

    var invokedClosureC = false
    var invokedClosureCCount = 0
    var stubbedClosureCResult: (() -> Void)! = {}

    func closureC() -> () -> Void {
        invokedClosureC = true
        invokedClosureCCount += 1
        return stubbedClosureCResult
    }

    var invokedClosureD = false
    var invokedClosureDCount = 0
    var stubbedClosureDResult: ((String, Int) -> ())! = { _, _ in }

    func closureD() -> (String, Int) -> () {
        invokedClosureD = true
        invokedClosureDCount += 1
        return stubbedClosureDResult
    }

    var invokedClosureE = false
    var invokedClosureECount = 0
    var stubbedClosureEResult: (() -> (String))! = { return "" }

    func closureE() -> () -> (String) {
        invokedClosureE = true
        invokedClosureECount += 1
        return stubbedClosureEResult
    }
}
