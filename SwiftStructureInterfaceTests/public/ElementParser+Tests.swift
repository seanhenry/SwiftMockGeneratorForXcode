@testable import SwiftStructureInterface

extension ElementParser {

    static func parseVariableDeclaration(_ string: String) throws -> VariableDeclaration {
        let type = try FileParser(fileContents: string).parseVariableDeclaration()
        return ManagedElementVisitor.wrap(type) as! VariableDeclaration
    }

    static func parseFunctionDeclaration(_ string: String) throws -> FunctionDeclaration {
        let type = try FileParser(fileContents: string).parseFunctionDeclaration()
        return ManagedElementVisitor.wrap(type) as! FunctionDeclaration
    }
}
