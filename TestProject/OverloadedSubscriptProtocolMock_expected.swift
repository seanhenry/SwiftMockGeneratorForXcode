@testable import TestProject

class OverloadedSubscriptProtocolMock: OverloadedSubscriptProtocol {

    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var stubbedSubscriptResult: Int! = 0

    subscript() -> Int {
        invokedSubscriptGetter = true
        invokedSubscriptGetterCount += 1
        return stubbedSubscriptResult
    }

    var invokedSubscriptAGetter = false
    var invokedSubscriptAGetterCount = 0
    var invokedSubscriptAGetterParameters: (a: Int, Void)?
    var invokedSubscriptAGetterParametersList = [(a: Int, Void)]()
    var stubbedSubscriptAResult: Int! = 0

    subscript(a: Int) -> Int {
        invokedSubscriptAGetter = true
        invokedSubscriptAGetterCount += 1
        invokedSubscriptAGetterParameters = (a, ())
        invokedSubscriptAGetterParametersList.append((a, ()))
        return stubbedSubscriptAResult
    }

    var invokedSubscriptBGetter = false
    var invokedSubscriptBGetterCount = 0
    var invokedSubscriptBGetterParameters: (b: Int, Void)?
    var invokedSubscriptBGetterParametersList = [(b: Int, Void)]()
    var stubbedSubscriptBResult: Int! = 0

    subscript(b b: Int) -> Int {
        invokedSubscriptBGetter = true
        invokedSubscriptBGetterCount += 1
        invokedSubscriptBGetterParameters = (b, ())
        invokedSubscriptBGetterParametersList.append((b, ()))
        return stubbedSubscriptBResult
    }

    var invokedSubscriptCIntGetter = false
    var invokedSubscriptCIntGetterCount = 0
    var invokedSubscriptCIntGetterParameters: (c: Int, Void)?
    var invokedSubscriptCIntGetterParametersList = [(c: Int, Void)]()
    var stubbedSubscriptCIntResult: Int! = 0

    subscript(c c: Int) -> Int {
        invokedSubscriptCIntGetter = true
        invokedSubscriptCIntGetterCount += 1
        invokedSubscriptCIntGetterParameters = (c, ())
        invokedSubscriptCIntGetterParametersList.append((c, ()))
        return stubbedSubscriptCIntResult
    }

    var invokedSubscriptCStringGetter = false
    var invokedSubscriptCStringGetterCount = 0
    var invokedSubscriptCStringGetterParameters: (c: String, Void)?
    var invokedSubscriptCStringGetterParametersList = [(c: String, Void)]()
    var stubbedSubscriptCStringResult: Int! = 0

    subscript(c c: String) -> Int {
        invokedSubscriptCStringGetter = true
        invokedSubscriptCStringGetterCount += 1
        invokedSubscriptCStringGetterParameters = (c, ())
        invokedSubscriptCStringGetterParametersList.append((c, ()))
        return stubbedSubscriptCStringResult
    }
}
