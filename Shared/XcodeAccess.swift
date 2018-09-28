import AppleScriptObjC

class XcodeAccess {
    static func requestAccess() -> Bool {
        guard #available(OSX 10.14, *) else {
            return true
        }
        if var addressDesc = NSAppleEventDescriptor(bundleIdentifier: "com.apple.dt.Xcode").aeDesc?.pointee {
            let appleScriptPermission = AEDeterminePermissionToAutomateTarget(&addressDesc, typeWildCard, typeWildCard, true)
            AEDisposeDesc(&addressDesc)
            return appleScriptPermission == noErr
        }
        return false
    }
}
