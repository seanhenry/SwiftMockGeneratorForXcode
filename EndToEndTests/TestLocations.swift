import Cocoa

// The test project is copied to the resources directory build phases
let testProject = Bundle(for: EndToEndTests.self)
    .resourceURL!
    .appendingPathComponent("/TestProject/TestProject.xcodeproj")
let testProjectPath = testProject.deletingLastPathComponent().path
