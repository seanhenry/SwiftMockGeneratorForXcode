import Crashlytics
import Fabric

public class Analytics: NSObject {
    
    @objc public static func initCrashlytics() {
        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
        #if !DEBUG
        Fabric.with([Crashlytics.self, Answers.self])
        #endif
    }
    
    public static func track(_ name: String, attributes: [String: Any]) {
        #if !DEBUG
        Answers.logCustomEvent(withName: name, customAttributes: attributes)
        #endif
    }
}
