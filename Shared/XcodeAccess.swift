protocol XcodeAccess {
    typealias Status = XcodeAccessStatus
    func check() -> Status
    func request() -> Status
}

enum XcodeAccessStatus {
    case granted, denied, requiresConsent, notRunning, unknown(Int)
}
