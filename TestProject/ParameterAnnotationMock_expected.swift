@testable import TestProject

class ParameterAnnotationMock: ParameterAnnotation {
    var invokedEscaping = false
    var invokedEscapingCount = 0
    var shouldInvokeEscapingClosure = false
    func escaping(closure: @escaping () -> ()) {
        invokedEscaping = true
        invokedEscapingCount += 1
        if shouldInvokeEscapingClosure {
            closure()
        }
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
    var shouldInvokeAutoclosureClosure = false
    func autoclosure(closure: @autoclosure () -> ()) {
        invokedAutoclosure = true
        invokedAutoclosureCount += 1
        if shouldInvokeAutoclosureClosure {
            closure()
        }
    }
    var invokedConvention = false
    var invokedConventionCount = 0
    var shouldInvokeConventionClosure = false
    func convention(closure: @convention(swift) () -> ()) {
        invokedConvention = true
        invokedConventionCount += 1
        if shouldInvokeConventionClosure {
            closure()
        }
    }
}
