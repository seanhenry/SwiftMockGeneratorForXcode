import Cocoa

public class XPCManager {
    
    public static var connection: Connection!
    
    public static func setUpConnection() {
        let xpcConnection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
        xpcConnection.remoteObjectInterface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
        xpcConnection.resume()
        connection = Connection(xpcConnection)
    }

    public static func resetConnection() {
        connection.invalidationHandler {  }
        connection.invalidateConnection()
        setUpConnection()
    }
}
