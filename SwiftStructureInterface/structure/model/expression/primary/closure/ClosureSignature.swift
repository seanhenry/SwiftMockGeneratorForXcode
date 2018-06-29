public protocol ClosureSignature: Element {
    var captureList: CaptureList? { get }
    var closureParameterClause: ClosureParameterClause { get }
    var functionResult: FunctionResult? { get }
}
