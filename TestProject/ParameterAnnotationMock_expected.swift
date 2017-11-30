@testable import TestProject

class ParameterAnnotationMock: ParameterAnnotation {
    var invokedEscaping = false
    var invokedEscapingCount = 0
    func escaping(closure: @escaping () -> ()) {
        invokedEscaping = true
        invokedEscapingCount += 1
        closure()
    }
    var invokedInOut = false
    var invokedInOutCount = 0
    var invokedInOutParameters: (var1: Int, Void)?
    var invokedInOutParametersList = [(var1: Int, Void)]()
    func inOut(var1: inout Int) {
        invokedInOut = true
        invokedInOutCount += 1
        invokedInOutParameters = (var1, ())
        invokedInOutParametersList.append((var1, ()))
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
