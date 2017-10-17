protocol DataStore {
    func save(_ data: Data, to file: URL, progress: (TimeInterval) -> ()) -> Bool
}
