protocol TupleProtocol {
    func tuple(a: ())
    func tuple(b: (Void))
    func tuple(c: (String, Int))
    func tuple(d: (d0: String, d1: Int))
    func tuple(e: (e0: String, Int))
    func returnEmpty() -> ()
    func returnVoid() -> (Void)
    func returnTuple() -> (String, Int)
    func returnLabelled() -> (a: String, b: Int)
    func returnPartiallyLabelled() -> (a: String, b: Int)
}
