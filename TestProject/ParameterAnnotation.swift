protocol ParameterAnnotation {
    func escaping(closure: @escaping () -> ())
//    func inOut(var1: inout Int)
    func autoclosure(closure: @autoclosure () -> ())
    func convention(closure: @convention(swift) () -> ())
}
