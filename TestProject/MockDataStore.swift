@testable import TestProject

class MockDataStore: DataStore {
    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (data: Data, file: URL)?
    var invokedSaveParametersList = [(data: Data, file: URL)]()
    var stubbedSaveResult: Bool!
    func save(_ data: Data, to file: URL) -> Bool {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (data, file)
        invokedSaveParametersList.append((data, file))
        return stubbedSaveResult
    }
}

class MyObject {
    init(dataStore: DataStore) {}
    @discardableResult func writeSomeData() -> Bool { return true }
}

import XCTest

class ExampleTest: XCTestCase {

    var mockDataStore: MockDataStore!
    var object: MyObject!
    let expectedData = "some data".data(using: .utf8)
    let expectedFile = URL(fileURLWithPath: "/test/file/1")
    let anotherExpectedFile = URL(fileURLWithPath: "/test/file/2")

    override func setUp() {
        super.setUp()
        mockDataStore = MockDataStore()
        object = MyObject(dataStore: mockDataStore)
    }

    override func tearDown() {
        mockDataStore = nil
        object = nil
        super.tearDown()
    }

    func testSaveWasInvoked() {
        object.writeSomeData()
        XCTAssertTrue(mockDataStore.invokedSave)
    }

    func testCorrectDataWasSavedToCorrectLocation() {
        object.writeSomeData()
        XCTAssertEqual(mockDataStore.invokedSaveParameters?.data, expectedData)
        XCTAssertEqual(mockDataStore.invokedSaveParameters?.file, expectedFile)
    }

    func testSaveWasInvokedTwice() {
        object.writeSomeData()
        object.writeSomeData()
        XCTAssertEqual(mockDataStore.invokedSaveCount, 2)
    }

    func testDataWasSavedToTwoDifferentFiles() {
        object.writeSomeData()
        object.writeSomeData()
        XCTAssertEqual(mockDataStore.invokedSaveParametersList[0].file, expectedFile)
        XCTAssertEqual(mockDataStore.invokedSaveParametersList[1].file, anotherExpectedFile)
    }

    func testMyMethodReturnsTrueWhenSaveWasSuccessful() {
        mockDataStore.stubbedSaveResult = true
        let result = object.writeSomeData()
        XCTAssertTrue(result)
    }
}
