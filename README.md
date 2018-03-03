# Swift Mock Generator Xcode Source Editor Extension
![Mock Generator Icon](readme/AppIcon_256.png)

An Xcode extension (plugin) to generate mock classes automatically.

![Xcode mock generator](readme/XcodeMockGenerator.gif)

[Looking for the AppCode version?](https://github.com/seanhenry/MockGenerator)

## Install Swift Mock Generator Xcode Source Editor Extension

- Download the latest release [here](https://github.com/seanhenry/SwiftMockGeneratorForXcode/releases)
- Copy the app to the `Applications` folder.
- Open the app
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

| Feature | Supported |
|---|---|
| Swift 3 and 4.|✅|
| Generate and regenerate your mock in one action.|✅|
| **Classes and protocols** |
| Generates mock conforming to one protocol.|✅|
| Generates mock conforming to a class.||
| Generates mock conforming to both classes and protocols.||
| **Recording methods and properties** |
| Captures invocation status of methods.|✅|
| Captures invocation status of properties.|✅|
| Records multiple invocations of methods.|✅|
| Records multiple invocations of properties.|✅|
| Captures invoked method parameters.|✅|
| Records multiple invocations of method parameters.|✅|
| **Stubbing return values and closures** |
| Stubs values for your mocks to return.|✅|
| Stubs a default value for return values where possible.|✅|
| Automatically calls closure parameters with stubbed values.|✅|
| **Initializers** |
| Generates convenience initializers requiring no parameters.||
| Supports initializers with arguments.||
| Supports failable initializers.||
| Supports required initializers.||
| **Throws** |
| Stub an error for your mock method to throw. ||
| Supports throwing initializers. ||
| Supports throwing closures. ||
| **Generics** |
| Generates generic mocks from protocols with associated types.||
| Captures invoked generic parameters. |✅ \*|
| Captures invoked generic return values. |✅ \*|
| **Scope, keywords, and more** |
| Avoids naming clashes from overloaded methods.|✅|
| Supports parameter type-annotation attributes and `inout`.|✅|
| Respects the mock scope and generates `public` and `open` methods and properties.||
| Generate mock inheriting from items in 3rd party frameworks.||

\* `where` clause not supported

## Feature requests

If there is a feature you need, check for an existing GitHub issue and make a comment or, if no issue exists, raise a new issue.

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
Stub the `progress` closure and it is called with the stubbed value:

```
func testStubProgressClosure() {
    mockDataStore.stubbedSaveProgressResult = (0.5, ())
    object.writeSomeData()
}
```
Closures without arguments are called automatically.

## Disable or remove the plugin

To disable:

Go to `System Preferences -> Extensions` and deselect the extension under `Xcode Source Editor`.

To remove:

Delete the app.

## Nomenclature

Despite being called a Mock Generator, this plugin actually generates something closer to a spy and stub. The word 'mock', whilst not technically correct, has been used because test doubles such as spies, mocks, and stubs have become colloquially known as mocks.

## Build

To bootstrap the project's dependencies use:
```
make
```
