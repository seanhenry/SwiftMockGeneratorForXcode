import AppleScriptObjC

class XcodeAccess {
    static func requestAccess() -> Bool {
        guard #available(OSX 10.14, *) else {
            return true
        }
        var addressDesc = AEAddressDesc(descriptorType: typeApplicationBundleID, dataHandle: nil)
        let bundleIdentifier = "com.apple.dt.Xcode"
        _ = AECreateDesc(typeApplicationBundleID, bundleIdentifier, strlen(bundleIdentifier), &addressDesc)
        let appleScriptPermission = AEDeterminePermissionToAutomateTarget(&addressDesc, typeWildCard, typeWildCard, true)
        AEDisposeDesc(&addressDesc)
        return appleScriptPermission == noErr
    }
}
