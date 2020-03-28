import XCTest
import SwiftyKit
import SwiftyServiceImpl
import Parser
import ASTSerialize
import MockGenerator

@objc(SetupTests) class SetupTests: NSObject {

    override init() {
        parserFactory = ParserFactory { PositionParser() }
        makeService = { SwiftyServiceImpl() }
        makeDeserializer = { ASTDeserializer() }
    }
}
