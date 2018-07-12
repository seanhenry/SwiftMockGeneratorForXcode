class DefaultArgumentClass {
    func method(with: String, defaultArg: Int = 0) {}
    func method(with: String = "", allDefaultArgs: Int = 0) {}
    func method(withComplicatedDefault: (String) -> Int = { _ in return 0 }) {}
}
