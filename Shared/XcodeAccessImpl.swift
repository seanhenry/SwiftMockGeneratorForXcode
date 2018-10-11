import AppleScriptObjC

class XcodeAccessImpl: XcodeAccess {

    func check() -> Status {
        guard #available(OSX 10.14, *) else {
            return .granted
        }
        return determinePermission(ask: false)
    }

    func request() -> Status {
        guard #available(OSX 10.14, *) else {
            return .granted
        }
        return determinePermission(ask: true)
    }

    @available(OSX 10.14, *)
    private func determinePermission(ask: Bool) -> Status {
        let errAEEventWouldRequireUserConsent = OSStatus(-1744)
        if var addressDesc = NSAppleEventDescriptor(bundleIdentifier: "com.apple.dt.Xcode").aeDesc?.pointee {
            let appleScriptPermission = AEDeterminePermissionToAutomateTarget(&addressDesc, typeWildCard, typeWildCard, ask)
            AEDisposeDesc(&addressDesc)
            switch appleScriptPermission {
            case noErr: return .granted
            case OSStatus(errAEEventNotPermitted): return .denied
            case errAEEventWouldRequireUserConsent: return .requiresConsent
            case OSStatus(procNotFound):
                return .notRunning
            default: return .unknown(Int(appleScriptPermission))
            }
        }
        return .unknown(-999)
    }
}
