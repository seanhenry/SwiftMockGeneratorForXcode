protocol DataStore {
    func save(_ data: Data, to file: URL) -> Bool
}
