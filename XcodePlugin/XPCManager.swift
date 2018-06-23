import Cocoa

public class XPCManager {
    
    public static var connection: Connection!
    
    public static func setUpConnection() {
        let xpcConnection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
        xpcConnection.remoteObjectInterface = createXPCInterface()
        xpcConnection.resume()
        connection = Connection(xpcConnection)
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

    public static func resetConnection() {
        connection.invalidationHandler {  }
        connection.invalidateConnection()
        setUpConnection()
    }
}
