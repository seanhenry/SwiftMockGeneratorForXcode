@testable import TestProject

class FolderSpacesMock: FolderSpaces {
    var invokedSimpleMethod = false
    var invokedSimpleMethodCount = 0
    func simpleMethod() {
        invokedSimpleMethod = true
        invokedSimpleMethodCount += 1
    }
}
