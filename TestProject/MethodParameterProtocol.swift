protocol MethodParameterProtocol {
    func oneParam(param0: Int)
    func twoParam(param0: Int, param1: String)
    func optionalParam(param0: Int?)
    func iuoParam(param0: Int!)
    func noLabelParam(_ name0: Int!)
    func nameAndLabelParam(label0 name0: Int!)
    func closureParam(param0: () -> ())
}
