@available(macOS 7, *)
class AvailableClass {
    @available(macOS 9.0, *)
    var property: String? { return nil }
    @available(macOS, deprecated, message: "Don't use this")
    func method() {} // Like in a swift header
}
