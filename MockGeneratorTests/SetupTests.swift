import XCTest
import SwiftyKit
import SwiftyServiceImpl
import Parser
import ASTSerialize
import MockGenerator

// The test project is copied to the resources directory build phases
let testProject = Bundle(for: InsertMockCommandTests.self).resourcePath! + "/TestProject"

@objc(SetupTests) class SetupTests: NSObject {

    override init() {
        setUpSwifty(projectURL: URL(fileURLWithPath: testProject), useTabs: false, indentationWidth: 4)
        parserFactory = ParserFactory { PositionParser() }
        makeService = { SwiftyServiceImpl() }
        makeDeserializer = { ASTDeserializer() }
    }
}
