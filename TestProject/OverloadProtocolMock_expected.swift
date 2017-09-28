import Foundation
@testable import TestProject

class MockOverloadProtocol: OverloadProtocol {
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
    var invokedIntAdding = false
    var invokedIntAddingCount = 0
    var invokedIntAddingParameters: (adding: Int, Void)?
    var invokedIntAddingParametersList = [(adding: Int, Void)]()
    var stubbedIntAddingResult: Int! = 0
    func int(adding: Int) -> Int {
        invokedIntAdding = true
        invokedIntAddingCount += 1
        invokedIntAddingParameters = (adding, ())
        invokedIntAddingParametersList.append((adding, ()))
        return stubbedIntAddingResult
    }
    var invokedSetValueStringForKey = false
    var invokedSetValueStringForKeyCount = 0
    var invokedSetValueStringForKeyParameters: (string: String, key: String)?
    var invokedSetValueStringForKeyParametersList = [(string: String, key: String)]()
    func setValue(_ string: String, forKey key: String) {
        invokedSetValueStringForKey = true
        invokedSetValueStringForKeyCount += 1
        invokedSetValueStringForKeyParameters = (string, key)
        invokedSetValueStringForKeyParametersList.append((string, key))
    }
    var invokedSetValueIntForKey = false
    var invokedSetValueIntForKeyCount = 0
    var invokedSetValueIntForKeyParameters: (int: Int, key: String)?
    var invokedSetValueIntForKeyParametersList = [(int: Int, key: String)]()
    func setValue(_ int: Int, forKey key: String) {
        invokedSetValueIntForKey = true
        invokedSetValueIntForKeyCount += 1
        invokedSetValueIntForKeyParameters = (int, key)
        invokedSetValueIntForKeyParametersList.append((int, key))
    }
    var invokedSetValueString = false
    var invokedSetValueStringCount = 0
    var invokedSetValueStringParameters: (value: String, Void)?
    var invokedSetValueStringParametersList = [(value: String, Void)]()
    func set(value: String) {
        invokedSetValueString = true
        invokedSetValueStringCount += 1
        invokedSetValueStringParameters = (value, ())
        invokedSetValueStringParametersList.append((value, ()))
    }
    var invokedSetValueInt = false
    var invokedSetValueIntCount = 0
    var invokedSetValueIntParameters: (value: Int, Void)?
    var invokedSetValueIntParametersList = [(value: Int, Void)]()
    func set(value: Int) {
        invokedSetValueInt = true
        invokedSetValueIntCount += 1
        invokedSetValueIntParameters = (value, ())
        invokedSetValueIntParametersList.append((value, ()))
    }
    var invokedAnimate = false
    var invokedAnimateCount = 0
    var stubbedAnimateResult: Bool! = false
    func animate() -> Bool {
        invokedAnimate = true
        invokedAnimateCount += 1
        return stubbedAnimateResult
    }
    var invokedAnimateWithDuration = false
    var invokedAnimateWithDurationCount = 0
    var invokedAnimateWithDurationParameters: (duration: TimeInterval, Void)?
    var invokedAnimateWithDurationParametersList = [(duration: TimeInterval, Void)]()
    func animate(withDuration duration: TimeInterval) {
        invokedAnimateWithDuration = true
        invokedAnimateWithDurationCount += 1
        invokedAnimateWithDurationParameters = (duration, ())
        invokedAnimateWithDurationParametersList.append((duration, ()))
    }
    var invokedAnimateWithDurationDelay = false
    var invokedAnimateWithDurationDelayCount = 0
    var invokedAnimateWithDurationDelayParameters: (duration: TimeInterval, delay: TimeInterval)?
    var invokedAnimateWithDurationDelayParametersList = [(duration: TimeInterval, delay: TimeInterval)]()
    func animate(withDuration duration: TimeInterval, delay: TimeInterval) {
        invokedAnimateWithDurationDelay = true
        invokedAnimateWithDurationDelayCount += 1
        invokedAnimateWithDurationDelayParameters = (duration, delay)
        invokedAnimateWithDurationDelayParametersList.append((duration, delay))
    }
}
