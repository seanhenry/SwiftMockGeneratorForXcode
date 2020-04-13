import Foundation

public func error(_ description: String) -> Error {
    return NSError(domain: "MockGenerator", code: 1, userInfo: [NSLocalizedDescriptionKey: description])
}
