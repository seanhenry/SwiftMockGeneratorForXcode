import Foundation

public class XPCManager {
    
    public static var connection: NSXPCConnection!
    
    public static func setUpConnection() {
        connection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
        connection?.remoteObjectInterface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
    }
}
