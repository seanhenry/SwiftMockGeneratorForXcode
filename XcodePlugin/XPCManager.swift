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
        let selector = #selector(MockGeneratorXPCProtocol.generateMock(fromFileContents:projectURL:line:column:templateName:withReply:))
        let classes = NSSet(array: [XPCBufferInstructions.self]) as! Set<AnyHashable>
        interface.setClasses(classes, for: selector, argumentIndex: 0, ofReply: true)
        return interface
    }

    public static func resetConnection() {
        connection.invalidationHandler {  }
        connection.invalidateConnection()
        setUpConnection()
    }
}
