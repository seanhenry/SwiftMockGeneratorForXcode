import Foundation

protocol CursorInfoRequest {
    func getCursorInfo(filePath: String, offset: Int64) throws -> [String: Any]
}
