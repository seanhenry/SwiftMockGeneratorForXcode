class Keywords {

    static let `associatedtype` = LeafNodeImpl(text: "associatedtype")
    static let `class` = LeafNodeImpl(text: "class")
    static let `deinit` = LeafNodeImpl(text: "deinit")
    static let `enum` = LeafNodeImpl(text: "enum")
    static let `extension` = LeafNodeImpl(text: "extension")
    static let `fileprivate` = LeafNodeImpl(text: "fileprivate")
    static let `func` = LeafNodeImpl(text: "func")
    static let `import` = LeafNodeImpl(text: "import")
    static let _init = LeafNodeImpl(text: "init")
    static let `inout` = LeafNodeImpl(text: "inout")
    static let `internal` = LeafNodeImpl(text: "internal")
    static let `let` = LeafNodeImpl(text: "let")
    static let `open` = LeafNodeImpl(text: "open")
    static let `operator` = LeafNodeImpl(text: "operator")
    static let `private` = LeafNodeImpl(text: "private")
    static let `protocol` = LeafNodeImpl(text: "protocol")
    static let `public` = LeafNodeImpl(text: "public")
    static let `static` = LeafNodeImpl(text: "static")
    static let `struct` = LeafNodeImpl(text: "struct")
    static let `subscript` = LeafNodeImpl(text: "subscript")
    static let `typealias` = LeafNodeImpl(text: "typealias")
    static let `var` = LeafNodeImpl(text: "var")
    static let `break` = LeafNodeImpl(text: "break")
    static let `case` = LeafNodeImpl(text: "case")
    static let `continue` = LeafNodeImpl(text: "continue")
    static let `default` = LeafNodeImpl(text: "default")
    static let `defer` = LeafNodeImpl(text: "defer")
    static let `do` = LeafNodeImpl(text: "do")
    static let `else` = LeafNodeImpl(text: "else")
    static let `fallthrough` = LeafNodeImpl(text: "fallthrough")
    static let `for` = LeafNodeImpl(text: "for")
    static let `guard` = LeafNodeImpl(text: "guard")
    static let `if` = LeafNodeImpl(text: "if")
    static let `in` = LeafNodeImpl(text: "in")
    static let `repeat` = LeafNodeImpl(text: "repeat")
    static let `return` = LeafNodeImpl(text: "return")
    static let `switch` = LeafNodeImpl(text: "switch")
    static let `where` = LeafNodeImpl(text: "where")
    static let `while` = LeafNodeImpl(text: "while")
    static let `as` = LeafNodeImpl(text: "as")
    static let `Any` = LeafNodeImpl(text: "Any")
    static let `catch` = LeafNodeImpl(text: "catch")
    static let `false` = LeafNodeImpl(text: "false")
    static let `is` = LeafNodeImpl(text: "is")
    static let `nil` = LeafNodeImpl(text: "nil")
    static let `rethrows` = LeafNodeImpl(text: "rethrows")
    static let `super` = LeafNodeImpl(text: "super")
    static let `self` = LeafNodeImpl(text: "self")
    static let `Self` = LeafNodeImpl(text: "Self")
    static let `throw` = LeafNodeImpl(text: "throw")
    static let `throws` = LeafNodeImpl(text: "throws")
    static let `true` = LeafNodeImpl(text: "true")
    static let `try` = LeafNodeImpl(text: "try")
    static let `_` = LeafNodeImpl(text: "_")
    static let `associativity` = LeafNodeImpl(text: "associativity")
    static let `convenience` = LeafNodeImpl(text: "convenience")
    static let `dynamic` = LeafNodeImpl(text: "dynamic")
    static let `didSet` = LeafNodeImpl(text: "didSet")
    static let `final` = LeafNodeImpl(text: "final")
    static let `get` = LeafNodeImpl(text: "get")
    static let `infix` = LeafNodeImpl(text: "infix")
    static let `indirect` = LeafNodeImpl(text: "indirect")
    static let `lazy` = LeafNodeImpl(text: "lazy")
    static let `left` = LeafNodeImpl(text: "left")
    static let `mutating` = LeafNodeImpl(text: "mutating")
    static let `none` = LeafNodeImpl(text: "none")
    static let `nonmutating` = LeafNodeImpl(text: "nonmutating")
    static let `optional` = LeafNodeImpl(text: "optional")
    static let `override` = LeafNodeImpl(text: "override")
    static let `postfix` = LeafNodeImpl(text: "postfix")
    static let `precedence` = LeafNodeImpl(text: "precedence")
    static let `prefix` = LeafNodeImpl(text: "prefix")
    static let _protocol = LeafNodeImpl(text: "Protocol")
    static let `required` = LeafNodeImpl(text: "required")
    static let `right` = LeafNodeImpl(text: "right")
    static let `set` = LeafNodeImpl(text: "set")
    static let type = LeafNodeImpl(text: "Type")
    static let `unowned` = LeafNodeImpl(text: "unowned")
    static let `weak` = LeafNodeImpl(text: "weak")
    static let `willSet` = LeafNodeImpl(text: "willSet")
    static let unsafe = LeafNodeImpl(text: "unsafe")
    static let safe = LeafNodeImpl(text: "safe")

    static let keywords: [String: LeafNodeImpl] = [
        "associatedtype": `associatedtype`,
        "class": `class`,
        "deinit": `deinit`,
        "enum": `enum`,
        "extension": `extension`,
        "fileprivate": `fileprivate`,
        "func": `func`,
        "import": `import`,
        "init": _init,
        "inout": `inout`,
        "internal": `internal`,
        "let": `let`,
        "open": `open`,
        "operator": `operator`,
        "private": `private`,
        "protocol": `protocol`,
        "public": `public`,
        "static": `static`,
        "struct": `struct`,
        "subscript": `subscript`,
        "typealias": `typealias`,
        "var": `var`,
        "break": `break`,
        "case": `case`,
        "continue": `continue`,
        "default": `default`,
        "defer": `defer`,
        "do": `do`,
        "else": `else`,
        "fallthrough": `fallthrough`,
        "for": `for`,
        "guard": `guard`,
        "if": `if`,
        "in": `in`,
        "repeat": `repeat`,
        "return": `return`,
        "switch": `switch`,
        "where": `where`,
        "while": `while`,
        "as": `as`,
        "Any": `Any`,
        "catch": `catch`,
        "false": `false`,
        "is": `is`,
        "nil": `nil`,
        "rethrows": `rethrows`,
        "super": `super`,
        "self": `self`,
        "Self": `Self`,
        "throw": `throw`,
        "throws": `throws`,
        "true": `true`,
        "try": `try`,
        "underscore": `_`,
        "associativity": `associativity`,
        "convenience": `convenience`,
        "dynamic": `dynamic`,
        "didSet": `didSet`,
        "final": `final`,
        "get": `get`,
        "infix": `infix`,
        "indirect": `indirect`,
        "lazy": `lazy`,
        "left": `left`,
        "mutating": `mutating`,
        "none": `none`,
        "nonmutating": `nonmutating`,
        "optional": `optional`,
        "override": `override`,
        "postfix": `postfix`,
        "precedence": `precedence`,
        "prefix": `prefix`,
        "Protocol": _protocol,
        "required": `required`,
        "right": `right`,
        "set": `set`,
        "Type": type,
        "unowned": `unowned`,
        "weak": `weak`,
        "willSet": `willSet`,
        "unsafe": unsafe,
        "safe": safe,
    ]

    private init() {}
}
