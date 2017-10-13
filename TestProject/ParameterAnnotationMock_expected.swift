@testable import TestProject

class ParameterAnnotationMock: ParameterAnnotation {
    var invokedEscaping = false
    var invokedEscapingCount = 0
    func escaping(closure: @escaping () -> ()) {
        invokedEscaping = true
        invokedEscapingCount += 1
        closure()
    }
    var invokedAutoclosure = false
    var invokedAutoclosureCount = 0
    func autoclosure(closure: @autoclosure () -> ()) {
        invokedAutoclosure = true
        invokedAutoclosureCount += 1
        closure()
    }
    var invokedConvention = false
    var invokedConventionCount = 0
    func convention(closure: @convention(swift) () -> ()) {
        invokedConvention = true
        invokedConventionCount += 1
        closure()
    }
}
