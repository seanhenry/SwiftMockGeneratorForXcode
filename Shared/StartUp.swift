import Crashlytics
import Fabric

class StartUp: NSObject {
    
    @objc static func initCrashlytics() {
        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
        #if !DEBUG
        Fabric.with([Crashlytics.self])
        #endif
    }
}
