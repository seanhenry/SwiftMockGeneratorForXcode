import XCTest
@testable import XcodePluginProxy

class XPCTests: MockGeneratorBaseTestCase {

    func test_canRestoreAnInvalidedXPCService() {
        XPCManager.setUpConnection().invalidateConnection()
        let e = expectation(description: #function)
        DispatchQueue.main.async {
            e.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        self.assertMockGeneratesExpected("SimpleProtocolMock")
    }
}
