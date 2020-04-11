@testable import TestProject

class KeywordsMock: Keywords {

    var invokedClassSetter = false
    var invokedClassSetterCount = 0
    var invokedClass: String?
    var invokedClassList = [String]()
    var invokedClassGetter = false
    var invokedClassGetterCount = 0
    var stubbedClass: String! = ""

    var `class`: String {
        set {
            invokedClassSetter = true
            invokedClassSetterCount += 1
            invokedClass = newValue
            invokedClassList.append(newValue)
        }
        get {
            invokedClassGetter = true
            invokedClassGetterCount += 1
            return stubbedClass
        }
    }

    var invokedRun = false
    var invokedRunCount = 0
    var invokedRunParameters: (for: Int, Void)?
    var invokedRunParametersList = [(for: Int, Void)]()

    func run(for: Int) {
        invokedRun = true
        invokedRunCount += 1
        invokedRunParameters = (`for`, ())
        invokedRunParametersList.append((`for`, ()))
    }

    var invokedFor = false
    var invokedForCount = 0
    var invokedForParameters: (in: String, Void)?
    var invokedForParametersList = [(in: String, Void)]()

    func `for`(in: String) {
        invokedFor = true
        invokedForCount += 1
        invokedForParameters = (`in`, ())
        invokedForParametersList.append((`in`, ()))
    }

    var invokedStatements = false
    var invokedStatementsCount = 0
    var invokedStatementsParameters: (break: Int, case: Int, continue: Int, default: Int, defer: Int, do: Int, else: Int, fallthrough: Int, for: Int, guard: Int, if: Int, in: Int, repeat: Int, return: Int, switch: Int, where: Int, while: Int)?
    var invokedStatementsParametersList = [(break: Int, case: Int, continue: Int, default: Int, defer: Int, do: Int, else: Int, fallthrough: Int, for: Int, guard: Int, if: Int, in: Int, repeat: Int, return: Int, switch: Int, where: Int, while: Int)]()

    func statements(break: Int, case: Int, continue: Int, default: Int, defer: Int, do: Int, else: Int, fallthrough: Int, for: Int, guard: Int, if: Int, in: Int, repeat: Int, return: Int, switch: Int, where: Int, while: Int) {
        invokedStatements = true
        invokedStatementsCount += 1
        invokedStatementsParameters = (`break`, `case`, `continue`, `default`, `defer`, `do`, `else`, `fallthrough`, `for`, `guard`, `if`, `in`, `repeat`, `return`, `switch`, `where`, `while`)
        invokedStatementsParametersList.append((`break`, `case`, `continue`, `default`, `defer`, `do`, `else`, `fallthrough`, `for`, `guard`, `if`, `in`, `repeat`, `return`, `switch`, `where`, `while`))
    }

    var invokedDeclarations = false
    var invokedDeclarationsCount = 0
    var invokedDeclarationsParameters: (associatedtype: Int, class: Int, deinit: Int, enum: Int, extension: Int, fileprivate: Int, func: Int, import: Int, init: Int, `inout`: Int, internal: Int, let: Int, open: Int, operator: Int, private: Int, protocol: Int, public: Int, static: Int, struct: Int, subscript: Int, typealias: Int, var: Int)?
    var invokedDeclarationsParametersList = [(associatedtype: Int, class: Int, deinit: Int, enum: Int, extension: Int, fileprivate: Int, func: Int, import: Int, init: Int, `inout`: Int, internal: Int, let: Int, open: Int, operator: Int, private: Int, protocol: Int, public: Int, static: Int, struct: Int, subscript: Int, typealias: Int, var: Int)]()

    func declarations(associatedtype: Int, class: Int, deinit: Int, enum: Int, extension: Int, fileprivate: Int, func: Int, import: Int, init: Int, `inout`: Int, internal: Int, `let`: Int, open: Int, operator: Int, private: Int, protocol: Int, public: Int, static: Int, struct: Int, subscript: Int, typealias: Int, `var`: Int) {
        invokedDeclarations = true
        invokedDeclarationsCount += 1
        invokedDeclarationsParameters = (`associatedtype`, `class`, `deinit`, `enum`, `extension`, `fileprivate`, `func`, `import`, `init`, `inout`, `internal`, `let`, `open`, `operator`, `private`, `protocol`, `public`, `static`, `struct`, `subscript`, `typealias`, `var`)
        invokedDeclarationsParametersList.append((`associatedtype`, `class`, `deinit`, `enum`, `extension`, `fileprivate`, `func`, `import`, `init`, `inout`, `internal`, `let`, `open`, `operator`, `private`, `protocol`, `public`, `static`, `struct`, `subscript`, `typealias`, `var`))
    }

    var invokedExpressionsAndTypes = false
    var invokedExpressionsAndTypesCount = 0
    var invokedExpressionsAndTypesParameters: (as: Int, Any: Int, catch: Int, false: Int, is: Int, nil: Int, rethrows: Int, super: Int, Self: Int, throw: Int, throws: Int, true: Int, try: Int)?
    var invokedExpressionsAndTypesParametersList = [(as: Int, Any: Int, catch: Int, false: Int, is: Int, nil: Int, rethrows: Int, super: Int, Self: Int, throw: Int, throws: Int, true: Int, try: Int)]()

    func expressionsAndTypes(as: Int, Any: Int, catch: Int, false: Int, is: Int, nil: Int, rethrows: Int, super: Int, Self: Int, throw: Int, throws: Int, true: Int, try: Int) {
        invokedExpressionsAndTypes = true
        invokedExpressionsAndTypesCount += 1
        invokedExpressionsAndTypesParameters = (`as`, `Any`, `catch`, `false`, `is`, `nil`, `rethrows`, `super`, `Self`, `throw`, `throws`, `true`, `try`)
        invokedExpressionsAndTypesParametersList.append((`as`, `Any`, `catch`, `false`, `is`, `nil`, `rethrows`, `super`, `Self`, `throw`, `throws`, `true`, `try`))
    }

    var invokedReserved = false
    var invokedReservedCount = 0
    var invokedReservedParameters: (associativity: Int, convenience: Int, dynamic: Int, didSet: Int, final: Int, get: Int, infix: Int, indirect: Int, lazy: Int, left: Int, mutating: Int, none: Int, nonmutating: Int, optional: Int, override: Int, postfix: Int, precedence: Int, prefix: Int, Protocol: Int, required: Int, right: Int, set: Int, Type: Int, unowned: Int, weak: Int, willSet: Int)?
    var invokedReservedParametersList = [(associativity: Int, convenience: Int, dynamic: Int, didSet: Int, final: Int, get: Int, infix: Int, indirect: Int, lazy: Int, left: Int, mutating: Int, none: Int, nonmutating: Int, optional: Int, override: Int, postfix: Int, precedence: Int, prefix: Int, Protocol: Int, required: Int, right: Int, set: Int, Type: Int, unowned: Int, weak: Int, willSet: Int)]()

    func reserved(associativity: Int, convenience: Int, dynamic: Int, didSet: Int, final: Int, get: Int, infix: Int, indirect: Int, lazy: Int, left: Int, mutating: Int, none: Int, nonmutating: Int, optional: Int, override: Int, postfix: Int, precedence: Int, prefix: Int, Protocol: Int, required: Int, right: Int, set: Int, Type: Int, unowned: Int, weak: Int, willSet: Int) {
        invokedReserved = true
        invokedReservedCount += 1
        invokedReservedParameters = (associativity, convenience, dynamic, didSet, final, get, infix, indirect, lazy, left, mutating, none, nonmutating, optional, override, postfix, precedence, prefix, Protocol, required, right, set, Type, unowned, weak, willSet)
        invokedReservedParametersList.append((associativity, convenience, dynamic, didSet, final, get, infix, indirect, lazy, left, mutating, none, nonmutating, optional, override, postfix, precedence, prefix, Protocol, required, right, set, Type, unowned, weak, willSet))
    }

    var invokedOpen = false
    var invokedOpenCount = 0

    func open() {
        invokedOpen = true
        invokedOpenCount += 1
    }
}
