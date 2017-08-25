import XCTest
@testable import $IMPORT$

class DeleteBodyUtilTests: XCTestCase {

    var util: DeleteBodyUtil!

    override func setUp() {
        super.setUp()
        util = DeleteBodyUtil()
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - $METHOD$

    func test_$METHOD$_should$WRITE_DESCRIPTION$() {
        util.$METHOD$()
        XCTAssert$END$
    }
}
