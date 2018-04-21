protocol DefaultValues {

    var int: Int { get set }
    var opt: Optional<Int> { get set }
    var shortOptional: Int? { get set }
    var doubleOptional: Int?? { get set }
    var iuo: Int! { get set }

    func optionalInt() -> Int?
    func iuoInt() -> Int!

    func double() -> Double
    func float() -> Float
    func int16() -> Int16
    func int32() -> Int32
    func int64() -> Int64
    func int8() -> Int8
    func uInt() -> UInt
    func uInt16() -> UInt16
    func uInt32() -> UInt32
    func uInt64() -> UInt64
    func uInt8() -> UInt8

    func array() -> Array<String>
    func arrayLiteral() -> [String]
    func arraySlice() -> ArraySlice<String>
    func contiguousArray() -> ContiguousArray<String>
    func set() -> Set<String>
    func optionalArray() -> Optional<Array<String>>
    func shortOptionalArray() -> [String]?

    func dictionary() -> Dictionary<String, String>
    func dictionaryLiteral() -> DictionaryLiteral<String, String>
    func dictionaryShorthand() -> [String: String]
    func optionalDict() -> Optional<Dictionary<String, String>>
    func shortOptionalDict() -> [String: String]?

    func bool() -> Bool

    func unicodeScalar() -> UnicodeScalar
    func character() -> Character
    func staticString() -> StaticString
    func string() -> String

    func closureA() -> () -> ()
    func closureB() -> () -> (Void)
    func closureC() -> () -> Void
    func closureD() -> (String, Int) -> ()
    func closureE() -> () -> (String)
}
