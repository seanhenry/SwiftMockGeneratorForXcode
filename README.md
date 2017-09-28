# Swift Mock Generator Xcode Source Editor Extension

An Xcode extension (plugin) to generate mock classes automatically.

![Xcode mock generator](readme/XcodeMockGenerator.gif)

[Looking for the AppCode version?](https://github.com/seanhenry/MockGenerator)

## Install Swift Mock Generator Xcode Source Editor Extension

- Download the latest release [here](https://github.com/seanhenry/SwiftMockGeneratorForXcode/releases)
- Copy the app to the `Applications` folder.
- Open the app
- Select the path to your project ([Why do I have to do this?](#why-do-i-have-to-set-a-path-to-my-project))
- Go to `System Preferences -> Extensions -> Xcode Source Editor` and make sure `Mock Generator` is enabled.
- Open Xcode

## How to create a new Swift mock

- Create an empty mock class conforming to a protocol.

Example:
```
class MyMock: MyProtocol {
}
```
- Place the cursor inside the class declaration.
- Click `Editor -> Mock Generator -> Generate Mock`.

## How to recreate a Swift mock

If you change the underlying protocol its mock will need to be regenerated.

To regenerate the mock, simply follow the steps above.

## Recommended: assign a shortcut

- Select preferences `⌘,` in Xcode.
- Choose 'Key Bindings'.
- Search for 'Mock Generator'.
- Choose your preferred shortcut. I prefer `⌃⌥⌘M`.

## Recommended: use source control

The mock generator will replace anything that is currently in your mock class with the generated mock.

Undo is supported for Xcode plugins but you're safer to use source control in the event of unexpectedly generating a mock.

## Features

| Feature | Xcode | AppCode
|---|---|---|
| Captures invocation status of methods.|✅|✅|
| Captures invocation status of properties.|✅|✅|
| Captures invoked method parameters.|✅|✅|
| Captures invoked property values.|✅|✅|
| Stubs values for your mocks to return.|✅|✅|
| Stubs a default value for return values where possible.|✅|✅|
| Automatically calls closure parameters with stubbed values.||✅|
| Supports mocks conforming to one or many protocols.||✅|
| Handles overloaded method declarations.|✅|✅|
| Regenerate your mock in one action.|✅|✅|
| Supports associated types.||✅|
| Supports parameter type-annotation attributes and inout.||✅|
| Respects public and open mocks and makes queries publicly available.||✅|
| Records multiple invocations of methods.|✅|✅|
| Records multiple invocations of method parameters.|✅|✅|
| Generate mocks from protocols in 3rd party frameworks.||✅|
| Generate mocks from classes|||

## Feature requests

As shown above, the AppCode plugin is much more feature-rich. If there is a feature you need, check for an existing GitHub issue and make a comment or, if no issue exists, raise a new issue.

## Usage example

A protocol called `DataStore` that we wish to mock:

```
protocol DataStore {
    func save(_ data: Data, to file: URL) -> Bool
}
```
Create a mock class conforming to the `DataStore` protocol:
```
class MockDataStore: DataStore {
}
```
Place the cursor in the class declaration and generate the mock:

```
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
```
Create and inject the mock into the class you wish to test:

```
override func setUp() {
    super.setUp()
    mockDataStore = MockDataStore()
    object = MyObject(dataStore: mockDataStore)
}
```
Test if the `save` method was invoked:

```
func testSaveWasInvoked() {
    object.writeSomeData()
    XCTAssertTrue(mockDataStore.invokedSave)
}
```
Test the parameters passed to the data store are correct:

```
func testCorrectDataWasSavedToCorrectLocation() {
    object.writeSomeData()
    XCTAssertEqual(mockDataStore.invokedSaveParameters?.data, expectedData)
    XCTAssertEqual(mockDataStore.invokedSaveParameters?.file, expectedFile)
}
```
Test the `save` method was called the correct number of times:

```
func testSaveWasInvokedTwice() {
    object.writeSomeData()
    object.writeSomeData()
    XCTAssertEqual(mockDataStore.invokedSaveCount, 2)
}
```
Test the parameters passed into each call of the data store are correct:

```
func testDataWasSavedToTwoDifferentFiles() {
    object.writeSomeData()
    object.writeSomeData()
    XCTAssertEqual(mockDataStore.invokedSaveParametersList[0].file, expectedFile)
    XCTAssertEqual(mockDataStore.invokedSaveParametersList[1].file, anotherExpectedFile)
}
```
Stub a return value for the `save` method:

```
func testMyMethodReturnsTrueWhenSaveWasSuccessful() {
    mockDataStore.stubbedSaveResult = true
    let result = object.writeSomeData()
    XCTAssertTrue(result)
}
```

## Disable or remove the plugin

To disable:

Go to `System Preferences -> Extensions` and deselect the extension under `Xcode Source Editor`.

To remove:

Delete the app.

## Nomenclature

Despite being called a Mock Generator, this plugin actually generates something closer to a spy and stub. The word 'mock', whilst not technically correct, has been used because test doubles such as spies, mocks, and stubs have become colloquially known as mocks.

## Why do I have to set a path to my project?

The plugin uses SourceKit which needs a list of your Swift files to index.

You have to set the path to your code because there is no way to derive it from an Xcode extension.

## Build

To bootstrap the project's dependencies use:
```
make
```
