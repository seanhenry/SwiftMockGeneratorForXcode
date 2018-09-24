typealias StringAlias = String
struct String {}
struct Int {}
struct UInt {}

class InferredTypeClass {
    var string = String("")
    var stringLiteral = ""
    var dictionaryLiteral = [String: Int]()
    var dictionaryLiteral2 = ["": 0]
    var arrayLiteral = [Int]()
    var arrayLiteral2 = [0]
    var asExpression = ["", 0] as [Any]
    var isExpression = "" is String
    var emptyClosure = {}
    var closureSignature = { (a: Int, b: String) throws -> UInt in return 0 }
    var returnClosure = { return 0 }
    var closureCall = { return "" }()
    var tuple = (0, String())
    var methodAssigned = InferredTypeClass.method()
    var propertyAssigned = InferredTypeClass.property

    private static func method() -> String {
        return "Method!"
    }

    private static let property = "Property!"
}
