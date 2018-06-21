import Cocoa

public class Connection {

    let connection: NSXPCConnection
    private var externalInvalidationHandler: (() -> ())?
    private var externalInterruptionHandler: (() -> ())?

    init(_ connection: NSXPCConnection) {
        self.connection = connection
        connection.invalidationHandler = { [weak self] in
            self?.externalInvalidationHandler?()
            DispatchQueue.main.async {
                _ = XPCManager.setUpConnection()
            }
        }
        connection.interruptionHandler = { [weak self] in
            self?.externalInterruptionHandler?()
        }
    }

    func invalidateConnection() {
        connection.invalidate()
    }

    func interruptionHandler(_ closure: @escaping () -> ()) {
        externalInterruptionHandler = closure
    }

    func invalidationHandler(_ closure: @escaping () -> ()) {
        externalInvalidationHandler = closure
    }

    func remoteObjectProxyWithErrorHandler(_ closure: @escaping (MockGeneratorXPCProtocol) -> (), _ errorHandler: @escaping (Error) -> ()) {
        let proxy = connection.remoteObjectProxyWithErrorHandler { error in
            errorHandler(error)
        }
        if let generator = proxy as? MockGeneratorXPCProtocol {
            closure(generator)
        } else {
            errorHandler(NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: "The XPC service failed to return a proxy."]))
        }
    }
}
