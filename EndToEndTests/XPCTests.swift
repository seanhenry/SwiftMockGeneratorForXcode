import XCTest
@testable import XcodePluginProxy

class XPCTests: MockGeneratorBaseTestCase {

    func test_canRestoreAnInvalidedXPCService() {
        invalidateConnection()
        self.assertMockGeneratesExpected("SimpleProtocolMock")
    }

    func test_shouldCallBlockWhenInvalidated() {
        var didInvokeClosure = false
        XPCManager.connection.invalidationHandler {
            didInvokeClosure = true
        }
        invalidateConnection()
        XCTAssert(didInvokeClosure)
    }

    // This must be manually tested
//    func test_shouldRecoverAfterCrashInXPC() {
//    }

    private func invalidateConnection() {
        XPCManager.connection.connection.invalidate()
        let e = expectation(description: #function)
        DispatchQueue.main.async {
            e.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
