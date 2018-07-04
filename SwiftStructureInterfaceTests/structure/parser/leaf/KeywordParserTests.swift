import XCTest
@testable import SwiftStructureInterface

class KeywordParserTests: XCTestCase {

    func test_parseUnknownKeyword() {
        XCTAssertThrowsError(try parse("unknown"))
    }

    func test_shouldAdvanceParser() {
        let parser = createParser("true false associatedtype func unknown", KeywordParser.self)
        XCTAssert(try parser.parse().text == Keywords.true)
        XCTAssert(try parser.parse().text == Keywords.false)
        XCTAssert(try parser.parse().text == Keywords.associatedtype)
        XCTAssert(try parser.parse().text == Keywords.func)
        XCTAssertThrowsError(try parser.parse())
    }

    func test_parseKeyword() {
        assertParsesKeyword("associatedtype", Keywords.associatedtype)
        assertParsesKeyword("class", Keywords.class)
        assertParsesKeyword("deinit", Keywords.deinit)
        assertParsesKeyword("enum", Keywords.enum)
        assertParsesKeyword("extension", Keywords.extension)
        assertParsesKeyword("fileprivate", Keywords.fileprivate)
        assertParsesKeyword("func", Keywords.func)
        assertParsesKeyword("import", Keywords.import)
        assertParsesKeyword("init", Keywords._init)
        assertParsesKeyword("inout", Keywords.inout)
        assertParsesKeyword("internal", Keywords.internal)
        assertParsesKeyword("let", Keywords.let)
        assertParsesKeyword("open", Keywords.open)
        assertParsesKeyword("operator", Keywords.operator)
        assertParsesKeyword("private", Keywords.private)
        assertParsesKeyword("protocol", Keywords.protocol)
        assertParsesKeyword("public", Keywords.public)
        assertParsesKeyword("static", Keywords.static)
        assertParsesKeyword("struct", Keywords.struct)
        assertParsesKeyword("subscript", Keywords.subscript)
        assertParsesKeyword("typealias", Keywords.typealias)
        assertParsesKeyword("var", Keywords.var)
        assertParsesKeyword("break", Keywords.break)
        assertParsesKeyword("case", Keywords.case)
        assertParsesKeyword("continue", Keywords.continue)
        assertParsesKeyword("default", Keywords.default)
        assertParsesKeyword("defer", Keywords.defer)
        assertParsesKeyword("do", Keywords.do)
        assertParsesKeyword("else", Keywords.else)
        assertParsesKeyword("fallthrough", Keywords.fallthrough)
        assertParsesKeyword("for", Keywords.for)
        assertParsesKeyword("guard", Keywords.guard)
        assertParsesKeyword("if", Keywords.if)
        assertParsesKeyword("in", Keywords.in)
        assertParsesKeyword("repeat", Keywords.repeat)
        assertParsesKeyword("return", Keywords.return)
        assertParsesKeyword("switch", Keywords.switch)
        assertParsesKeyword("where", Keywords.where)
        assertParsesKeyword("while", Keywords.while)
        assertParsesKeyword("as", Keywords.as)
        assertParsesKeyword("Any", Keywords.Any)
        assertParsesKeyword("catch", Keywords.catch)
        assertParsesKeyword("false", Keywords.false)
        assertParsesKeyword("is", Keywords.is)
        assertParsesKeyword("nil", Keywords.nil)
        assertParsesKeyword("rethrows", Keywords.rethrows)
        assertParsesKeyword("super", Keywords.super)
        assertParsesKeyword("self", Keywords.`self`)
        assertParsesKeyword("Self", Keywords.Self)
        assertParsesKeyword("throw", Keywords.throw)
        assertParsesKeyword("throws", Keywords.throws)
        assertParsesKeyword("true", Keywords.true)
        assertParsesKeyword("try", Keywords.try)
        assertParsesKeyword("_", Keywords._)
        assertParsesKeyword("associativity", Keywords.associativity)
        assertParsesKeyword("convenience", Keywords.convenience)
        assertParsesKeyword("dynamic", Keywords.dynamic)
        assertParsesKeyword("didSet", Keywords.didSet)
        assertParsesKeyword("final", Keywords.final)
        assertParsesKeyword("get", Keywords.get)
        assertParsesKeyword("infix", Keywords.infix)
        assertParsesKeyword("indirect", Keywords.indirect)
        assertParsesKeyword("lazy", Keywords.lazy)
        assertParsesKeyword("left", Keywords.left)
        assertParsesKeyword("mutating", Keywords.mutating)
        assertParsesKeyword("none", Keywords.none)
        assertParsesKeyword("nonmutating", Keywords.nonmutating)
        assertParsesKeyword("optional", Keywords.optional)
        assertParsesKeyword("override", Keywords.override)
        assertParsesKeyword("postfix", Keywords.postfix)
        assertParsesKeyword("precedence", Keywords.precedence)
        assertParsesKeyword("prefix", Keywords.prefix)
        assertParsesKeyword("Protocol", Keywords._Protocol)
        assertParsesKeyword("required", Keywords.required)
        assertParsesKeyword("right", Keywords.right)
        assertParsesKeyword("set", Keywords.set)
        assertParsesKeyword("Type", Keywords._Type)
        assertParsesKeyword("unowned", Keywords.unowned)
        assertParsesKeyword("weak", Keywords.weak)
        assertParsesKeyword("willSet", Keywords.willSet)
        assertParsesKeyword("unsafe", Keywords.unsafe)
        assertParsesKeyword("safe", Keywords.safe)
    }

    // MARK: - Helpers

    func assertParsesKeyword(_ input: String, _ expected: String, line: UInt = #line) {
        let leaf = try? parse(input)
        XCTAssertEqual(leaf?.text, expected, line: line)
    }

    private func parse(_ input: String) throws -> LeafNode {
        return try createParser(input, KeywordParser.self).parse()
    }
}
