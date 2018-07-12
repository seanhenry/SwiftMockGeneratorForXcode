import Cocoa

public class XPCManager {
    
    private static let xpcBundleIdentifier = Bundle.main.object(forInfoDictionaryKey: "XPC_BUNDLE_IDENTIFIER") as! String
    private(set) static var connection: Connection!
    private static let xpcQueue = DispatchQueue.global(qos: .userInteractive)
    
    public static func setUpConnection() {
        xpcQueue.sync {
            let xpcConnection = NSXPCConnection(serviceName: xpcBundleIdentifier)
            xpcConnection.remoteObjectInterface = self.createXPCInterface()
            xpcConnection.resume()
            self.connection = Connection(xpcConnection, xpcQueue)
        }
    }

    private static func createXPCInterface() -> NSXPCInterface {
        let interface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
        setClassesForRequest(interface)
        setClassesForReply(interface)
        return interface
    }

    private class func setClassesForRequest(_ interface: NSXPCInterface) {
        let selector = #selector(MockGeneratorXPCProtocol.generateMock(from:withReply:))
        let classes = NSSet(object: XPCMockGeneratorModel.self) as! Set<AnyHashable>
        interface.setClasses(classes, for: selector, argumentIndex: 0, ofReply: false)
    }

    private static func setClassesForReply(_ interface: NSXPCInterface) {
        let selector = #selector(MockGeneratorXPCProtocol.generateMock(from:withReply:))
        let classes = NSSet(object: XPCBufferInstructions.self) as! Set<AnyHashable>
        interface.setClasses(classes, for: selector, argumentIndex: 0, ofReply: true)
    }
}
