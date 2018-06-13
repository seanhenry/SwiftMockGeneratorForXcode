@testable import SwiftStructureInterface

extension ElementParser {

    static func parseVariableDeclaration(_ string: String) -> VariableDeclaration {
        let type = FileParser(fileContents: string).parseVariableDeclaration()
        return ManagedElementVisitor.wrap(type) as! VariableDeclaration
    }

    static func parseFunctionDeclaration(_ string: String) -> FunctionDeclaration {
        let type = FileParser(fileContents: string).parseFunctionDeclaration()
        return ManagedElementVisitor.wrap(type) as! FunctionDeclaration
    }
}
