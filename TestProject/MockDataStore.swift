@testable import TestProject

class MockDataStore: DataStore {
    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (data: Data, file: URL)?
    var invokedSaveParametersList = [(data: Data, file: URL)]()
    var stubbedSaveProgressResult: (TimeInterval, Void)?
    var stubbedSaveResult: Bool! = false
    func save(_ data: Data, to file: URL, progress: (TimeInterval) -> ()) -> Bool {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (data, file)
        invokedSaveParametersList.append((data, file))
        if let result = stubbedSaveProgressResult {
            progress(result.0)
        }
        return stubbedSaveResult
    }
}

class MyObject {

    let dataStore: DataStore, data: Data, file: URL

    init(dataStore: DataStore, data: Data, file: URL) {
        self.dataStore = dataStore
        self.data = data
        self.file = file
    }

    @discardableResult func writeSomeData() -> Bool {
        _ = dataStore.save(data, to: file) { _ in /* do something with progress */ }
        return true
    }
}

import XCTest

class ExampleTest: XCTestCase {

    var mockDataStore: MockDataStore!
    var object: MyObject!
    let expectedData = "some data".data(using: .utf8)!
    let expectedFile = URL(fileURLWithPath: "/test/file/1")

    override func setUp() {
        super.setUp()
        mockDataStore = MockDataStore()
        object = MyObject(dataStore: mockDataStore, data: expectedData, file: expectedFile)
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
        XCTAssertEqual(mockDataStore.invokedSaveParametersList[1].file, expectedFile)
    }

    func testMyMethodReturnsTrueWhenSaveWasSuccessful() {
        mockDataStore.stubbedSaveResult = true
        let result = object.writeSomeData()
        XCTAssertTrue(result)
    }

    func testStubProgressClosure() {
        mockDataStore.stubbedSaveProgressResult = (0.5, ())
        object.writeSomeData()
    }
}
