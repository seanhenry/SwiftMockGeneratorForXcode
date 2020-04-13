import Foundation

public protocol IO {
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool
}

extension FileManager: IO {}
