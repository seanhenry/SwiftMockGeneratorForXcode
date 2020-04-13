import SwiftyKit
import Foundation
import AST

public class GenerateMockCommand: MockGenerator {

    private let targetName: String
    private let importModules: [String]
    private let testableImportModules: [String]
    let templateName: String
    private let mockPrefix: String
    private let mockPostfix: String
    private let outDirectory: String
    private let generationComment: String
    private let io: IO

    private var className: String { "\(mockPrefix)\(targetName)\(mockPostfix)" }

    public init(
        targetName: String,
        importModules: [String],
        testableImportModules: [String],
        templateName: String,
        mockPrefix: String,
        mockPostfix: String,
        outDirectory: String,
        generationComment: String,
        io: IO = FileManager.default
    ) {
        self.targetName = targetName
        self.importModules = importModules
        self.testableImportModules = testableImportModules
        self.templateName = templateName
        self.mockPrefix = mockPrefix
        self.mockPostfix = mockPostfix
        self.outDirectory = outDirectory
        self.generationComment = generationComment
        self.io = io
    }

    public func execute() throws {
        let file = try makeFile()
        guard let typeDeclaration = file.typeDeclarations.first(where: { $0.name == className }) else {
            throw error("Could not build class declaration for \(className)")
        }
        try generateMock(toFile: file, atElement: typeDeclaration)
        try writeToFile(contents: file.text)
    }

    private func makeFile() throws -> File {
        let contents = """
        \(generationComment)
        \(importDeclarations)
        \(testableImportDeclarations)

        class \(className): \(targetName) {}
        """
        return try parserFactory.make().parseFile(contents, url: nil)
    }

    private var importDeclarations: String {
        return importModules.map { "import \($0)" }.joined(separator: "\n")
    }

    private var testableImportDeclarations: String {
        return testableImportModules.map { "@testable import \($0)" }.joined(separator: "\n")
    }

    private func writeToFile(contents: String) throws {
        let path = "\(outDirectory)/\(className).swift"
        let result = io.createFile(
            atPath: path,
            contents: contents.data(using: .utf8),
            attributes: nil
        )
        if !result {
            throw error("Could not write to the file at \(path)")
        }
    }
}
