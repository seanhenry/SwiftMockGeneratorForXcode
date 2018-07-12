import Cocoa

public class Connection {

    private let queue: DispatchQueue
    private let connection: NSXPCConnection
    private var externalInvalidationHandler: (() -> ())?
    private var externalInterruptionHandler: (() -> ())?

    init(_ connection: NSXPCConnection, _ queue: DispatchQueue) {
        self.connection = connection
        self.queue = queue
        connection.invalidationHandler = { [weak self] in
            self?.queue.async {
                self?.externalInvalidationHandler?()
            }
        }
        connection.interruptionHandler = { [weak self] in
            self?.queue.async {
                self?.externalInterruptionHandler?()
            }
        }
    }

    func interruptionHandler(_ closure: @escaping () -> ()) {
        queue.async { [weak self] in
            self?.externalInterruptionHandler = closure
        }
    }

    func invalidationHandler(_ closure: @escaping () -> ()) {
        queue.async { [weak self] in
            self?.externalInvalidationHandler = closure
        }
    }

    func remoteObjectProxyWithErrorHandler(_ closure: @escaping (MockGeneratorXPCProtocol) -> (), _ errorHandler: @escaping (Error) -> ()) {
        queue.async { [weak self] in
            let proxy = self?.connection.remoteObjectProxyWithErrorHandler { error in
                errorHandler(error)
            }
            if let generator = proxy as? MockGeneratorXPCProtocol {
                closure(generator)
            } else {
                errorHandler(NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: "The XPC service failed to return a proxy."]))
            }
        }
    }
}
