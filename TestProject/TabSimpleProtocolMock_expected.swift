@testable import TestProject

class TabSimpleProtocolMock: SimpleProtocol {

	var invokedSimpleMethod = false
	var invokedSimpleMethodCount = 0

	func simpleMethod() {
		invokedSimpleMethod = true
		invokedSimpleMethodCount += 1
	}
}
