typealias StringAlias = String
struct HelperClass: Hashable {}

class InferredTypeClass {
    var fromInitializer = HelperClass()
    var stringLiteral = ""
    var dictionaryLiteral = [HelperClass: HelperClass]()
    var dictionaryLiteral2 = ["": 0]
    var arrayLiteral = [HelperClass]()
    var arrayLiteral2 = [0]
    var asExpression = ["", 0] as [Any]
    var isExpression = "" is String
    var emptyClosure = {}
    var closureSignature = { (a: Int, b: String) throws -> UInt in return 0 }
    var returnClosure = { return 0 }
    var closureCall = { return "" }()
    var tuple = (0, "")
    var methodAssigned = InferredTypeClass.method()
    var propertyAssigned = InferredTypeClass.property

    private static func method() -> String {
        return "Method!"
    }

    private static let property = "Property!"
}
