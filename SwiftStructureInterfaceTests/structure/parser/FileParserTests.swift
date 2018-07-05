import XCTest
@testable import SwiftStructureInterface

class FileParserTests: XCTestCase {

    var parser: FileParser!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseFile() {
        let contents = "protocol P {}"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseUTF16File() {
        let contents = "protocol 💐 {}"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseComments() {
        let contents = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseWhitespaceAtBeginningAndEndOfFile() {
        let contents = "  protocol P {}  "
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_shouldParseChaoticFile() throws {
        let file = try parse(FileParserTests.chaoticFile)
        StringCompareTestHelper.assertEqualStrings(file.text, FileParserTests.chaoticFile)
        StringCompareTestHelper.assertEqualStrings(file.typeDeclarations[0].codeBlock.text, FileParserTests.chaoticClassBody)
        StringCompareTestHelper.assertEqualStrings(file.typeDeclarations[0].typeDeclarations[0].text, FileParserTests.chaoticNestedClass)
    }

    private func parse(_ input: String) throws -> File {
        let parser = FileParser(fileContents: input)
        return try parser.parse()
    }

    private static let chaoticFile = """
    @a import struct My.Imported.Item
@testable import MyModule
import XCTest
import Foundation.NSArray

@a private final let assign = 0
let typeAnnotation: Int
let _
var identifier
let (x, y): (Int, Int)

class MockClass: AClass, AProtocol \(chaoticClassBody)



"""

    private static let chaoticClassBody = """
{

    @a private final let assign = 0
    let typeAnnotation: Int
    let _
    var identifier
    let (x, y): (Int, Int)

    @a public mutating override var assign = 0
    var typeAnnotation: Int = expression(9)
    var _, a, b: String = "asd", c: Int = 0
    var (x, y): (Int, Int)

    var computed: String {
        let _ = String(repeating: " ", count: 12)
        return ""
    }

    var Computed2: Int {
        get {
            let fiftyMillion = 50_000_000
            return fiftyMillion ** 2
        }
    }

    var transient: Int<Shape> {
        set(v) {
            other = v.callSome()
        } get { return -21 }
    }

    var uhoh: Int<Shape> { @g mutating get @s nonmutating set }

    var willDid: Array<[Int]> {
        willSet(newValue) {
            doSomethingElse(newValue, willDid)
        }
        didSet(oldValue) {
            error(["String": asd, asd: "String"], [1, 2, 3, 4])
        }
    }

    @a public(set) typealias MyType<T: E> = [T: E]

    func f(x: Int = 42) -> Int { return x }

    func alwaysThrows() throws {
        throw SomeError.error
    }
    func someFunction(callback: () throws -> Void) rethrows {
        do {
            try callback()
            try alwaysThrows()  // Invalid, alwaysThrows() isn't a throwing parameter
        } catch {
            throw AnotherError.error
        }
    }

    @objc @available(iOS, *) internal(set) func someFunction<T, U: A&B>(_ a: A, _ b: B, c: C, d: D = 123 == true, E:E...) where T: Element, T.Elem == A {
        guard let something = .implicit(0), bool == true else { fatalError() }
        while asd in 57 {

        }
        repeat {
            func a() {}
            let _ = a()
            a += 11
        } while 87 is Int

        do {
            try! something(set: "qwe", [0123]) {
                return 123
            }
            try? opt()
            try throwingMethod() -> String
        }
    }


    func patterns() {

        if case .some(let x) = someOptional {
            print( x )
        }

        labelled :  for case let number? in arrayOfOptionalInts where "this".uppercased().isRight  {
            .
            print("Found a \\(number)")


        }

        if a is T {

        } else if if let a = b as? T {

        } else

        let point = (1, 2)
        switch point {
        case (0, 0):
            print("(0, 0) is at the origin.")
        case (-2...2, -2...2):
            print("(\\(point.0), \\(point.1)) is near the origin.")
        default:
            print("The point is at (\\(point.0), \\(point.1)).")
        }

        func ~= (pattern: String, value: Int) -> Bool {
            return pattern == "\\(value)"
        }
        switch point {
        case ("0", "0") where 27 isNotNil:
            print("(0, 0) is at the origin.")
        default:
            print("The point is at (\\(point.0), \\(point.1)).")
        }


    }

    private struct Error: Swift.Error {}

    public indirect enum Platform: RawRepresentable {
        case ios, macOS

            case .tvOS
case watchOS(Platform, String<T>)

        func switching() {
            switch self {
                default where neverTrue(): {
                    return Set<Int>(a: [a, b, c]);
                }
            }
        }

        static func <-->(lhs: Platform?, _ rhs: Platform!, line: UInt = #line) -> () -> () {
            return {
                lhs - rhs as String
            }
        }
    }

    deinit {
        self.init(a: 0)
                }

    convenience dynamic required init() {

    }

    extension Ext where A == Self, B: Self.Element {

    }


        \(chaoticNestedClass)

    protocol NestedProtocol: class, NESTED_CLASS where A: B {
        func a(a: A = default)
        indirect 100
        @available({}[]()*) public var : Void { }
        var a: Int { get }
            associatedtype = Int
typealias is = Int
        subscript(a: Int) ->Bool
        required convenience init(int: Int = 0x2, int: Int = 0b01, int: Int = 0o014)
    }

precedencegroup GroupName, name2, {
higherThan   assignment associativity : left
}
}
"""

    static let chaoticNestedClass = """
class NESTED_CLASS: class {
            func nestedClassFunc() {

            }
}
"""
}
