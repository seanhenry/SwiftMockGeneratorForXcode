import XCTest
@testable import SwiftStructureInterface

class NaiveFormatterTests: XCTestCase {

    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: NaiveFormatterTests.self).resourcePath! + "/TestProject"

    var formatter: NaiveFormatter!
    let spaces = 2

    override func setUp() {
        super.setUp()
        formatter = NaiveFormatter(useTabs: false, spaces: spaces)
    }

    func test_shouldFormatSingleLine_whenNoCodeBlock() {
        assertFormatted("var a: A", "var a: A")
    }

    func test_shouldCountTouchingBraces() {
        assertFormatted("{}var a: A", "{}var a: A")
    }

    func test_shouldHandleNegativeNumberOfBraces() {
        assertFormatted("}var a: A", "}var a: A")
    }

    func test_shouldFormatSingleLine_whenNestedInClass() {
        assertFormatted("""
        class A {
        var a: A
        """, """
        class A {
          var a: A
        }
        """)
    }

    func test_shouldFormatSingleLine_whenNestedInClass_2Levels() {
        assertFormatted("""
        class A {
        class B {
        var a: A
        }
        }
        """, """
        class A {
          class B {
            var a: A
          }
        }
        """)
    }

    func test_shouldFormatSingleLine_whenNextToAClass() {
        assertFormatted("""
        class A {
        }
        var a: A
        """, """
        class A {
        }
        var a: A
        """)
    }

    func test_shouldFormatSingleLine_whenNestedAndNextToAClass() {
        assertFormatted("""
        class A {}
        class B {
        class C {  
        var a: A
        }
        }
        """, """
        class A {}
        class B {
          class C {
            var a: A
          }
        }
        """)
    }

    func test_shouldTrimLinesOfWhitespace() {
        assertFormatted("""
           class A {  
            func a() {  
          invokedA = true  
                      }   
                   }   
        """, """
        class A {
          func a() {
            invokedA = true
          }
        }
        """)
    }

    func test_shouldHandleNegativeNumberOfBracesInLine() {
        assertFormatted("}", "}")
    }

    func test_shouldIndentUsingTabs() {
        formatter = NaiveFormatter(useTabs: true, spaces: spaces)
        assertFormatted("""
        class A {
        var a: A
        }
        """, "class A {\n\tvar a: A\n}")
        assertFormatted("""
        class A {
        class B {
        var a: A
        }
        }
        """, "class A {\n\tclass B {\n\t\tvar a: A\n\t}\n}")
    }

    func test_shouldIndentUsingDifferentNumberOfSpaces() {
        formatter = NaiveFormatter(useTabs: false, spaces: 4)
        assertFormatted("""
        class A {
        var a: A
        }
        """, "class A {\n    var a: A\n}")
        assertFormatted("""
        class A {
        class B {
        var a: A
        }
        }
        """, "class A {\n    class B {\n        var a: A\n    }\n}")
    }

    func test_realExample() {
        formatter = NaiveFormatter(useTabs: false, spaces: 4)
        let expected = try! String(contentsOfFile: testProject + "/NestedClassPerformanceTest_formatted.swift")
        let lines = expected.components(separatedBy: "\n")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .joined(separator: "\n")
        assertFormatted(lines, expected)
    }

    private func assertFormatted(_ input: String, _ expected: String, line: UInt = #line) {
        let lines = input.components(separatedBy: "\n")
        let expectedLines = expected.components(separatedBy: "\n")
        let result = formatter.format(lines: lines)
        zip(result, expectedLines).forEach { lhs, rhs in
            XCTAssertEqual(lhs, rhs, line: line)
        }
    }
}
