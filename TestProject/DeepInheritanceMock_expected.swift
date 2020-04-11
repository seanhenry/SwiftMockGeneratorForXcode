@testable import TestProject

class DeepInheritanceMock: TopMostProtocol, TopMostSiblingProtocol {

    var invokedTopMost = false
    var invokedTopMostCount = 0

    func topMost() {
        invokedTopMost = true
        invokedTopMostCount += 1
    }

    var invokedTopSibling = false
    var invokedTopSiblingCount = 0

    func topSibling() {
        invokedTopSibling = true
        invokedTopSiblingCount += 1
    }

    var invokedMiddle = false
    var invokedMiddleCount = 0

    func middle() {
        invokedMiddle = true
        invokedMiddleCount += 1
    }

    var invokedMiddleSibling1 = false
    var invokedMiddleSibling1Count = 0

    func middleSibling1() {
        invokedMiddleSibling1 = true
        invokedMiddleSibling1Count += 1
    }

    var invokedMiddleSibling2 = false
    var invokedMiddleSibling2Count = 0

    func middleSibling2() {
        invokedMiddleSibling2 = true
        invokedMiddleSibling2Count += 1
    }

    var invokedDeepest = false
    var invokedDeepestCount = 0

    func deepest() {
        invokedDeepest = true
        invokedDeepestCount += 1
    }

    var invokedDeepestSibling = false
    var invokedDeepestSiblingCount = 0

    func deepestSibling() {
        invokedDeepestSibling = true
        invokedDeepestSiblingCount += 1
    }

    var invokedDeepestCousin = false
    var invokedDeepestCousinCount = 0

    func deepestCousin() {
        invokedDeepestCousin = true
        invokedDeepestCousinCount += 1
    }
}
