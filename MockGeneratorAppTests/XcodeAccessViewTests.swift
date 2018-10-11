import XCTest
@testable import MockGeneratorApp

class XcodeAccessViewTests: XCTestCase {

    var accessSpy: XcodeAccessSpy!
    var view: XcodeAccessView!

    override func setUp() {
        super.setUp()
        accessSpy = XcodeAccessSpy()
        accessSpy.stubbedRequestResult = .denied
        XcodeAccessView.xcodeAccess = accessSpy
        view = XcodeAccessView()
        view.messageField = NSTextField()
        view.fixButton = NSButton()
    }

    func test_shouldShowGrantedMessage() {
        assertStatusMessage("✔︎ Mock Generator has access to Xcode", for: .granted)
    }

    func test_shouldShowDeniedMessage() {
        assertStatusMessage("⚠️ Mock Generator does not have permission to access Xcode.\nGo to System Preferences -> Security & Privacy -> Privacy -> Automation and make sure this app is allowed to control Xcode.\nThen restart the app.", for: .denied)
    }

    func test_shouldShowUnknownMessage() {
        assertStatusMessage("⚠️ Mock Generator does not have permission to access Xcode for an unknown reason (100)", for: .unknown(100))
    }

    func test_shouldShowNotRunningMessage() {
        assertStatusMessage("Open Xcode to check if Mock Generator has access to Xcode", for: .notRunning)
    }

    func test_shouldShowRequiresConsentMessage() {
        assertStatusMessage("Requesting access to Xcode...", for: .requiresConsent)
    }

    func test_shouldHideFixButton() {
        assertFixButton(isHidden: true, for: .requiresConsent)
        assertFixButton(isHidden: true, for: .unknown(0))
        assertFixButton(isHidden: true, for: .notRunning)
        assertFixButton(isHidden: true, for: .granted)
    }

    func test_shouldShowFixButtonForDeniedStatus() {
        assertFixButton(isHidden: false, for: .denied)
    }

    private func assertStatusMessage(_ expected: String, for status: XcodeAccessStatus, line: UInt = #line) {
        accessSpy.stubbedRequestResult = status
        view.updateView()
        XCTAssertEqual(view.messageField?.stringValue, expected, line: line)
    }

    private func assertFixButton(isHidden: Bool, for status: XcodeAccessStatus, line: UInt = #line) {
        accessSpy.stubbedRequestResult = status
        view.updateView()
        XCTAssertEqual(view.fixButton?.isHidden, isHidden, line: line)
    }

    private func assertRequestsPermissions(_ expected: Bool, for status: XcodeAccessStatus, line: UInt = #line) {
        accessSpy.stubbedRequestResult = status
        view.updateView()
        XCTAssertEqual(accessSpy.invokedRequest, expected, line: line)
    }

    class XcodeAccessSpy: XcodeAccess {
        var invokedCheck = false
        var invokedCheckCount = 0
        var stubbedCheckResult: Status!
        func check() -> Status {
            invokedCheck = true
            invokedCheckCount += 1
            return stubbedCheckResult
        }
        var invokedRequest = false
        var invokedRequestCount = 0
        var stubbedRequestResult: Status!
        func request() -> Status {
            invokedRequest = true
            invokedRequestCount += 1
            return stubbedRequestResult
        }
    }
}
