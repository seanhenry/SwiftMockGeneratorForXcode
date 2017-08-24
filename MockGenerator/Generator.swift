import Foundation
@testable import SwiftStructureInterface
import SourceKittenFramework

public class Generator {
    
    public static func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int) -> ([String]?, Error?) {
        
        // TODO: put files elsewhere
        ResolveUtil.files = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        // TODO: fully encapsulate SourceKitten
        let structure = Structure(file: File(contents: contents))
        let element = StructureBuilder(data: structure.dictionary, text: contents).build()
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: contents) else {
            return reply(with: "cursor not found")
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: element, cursorOffset: cursorOffset) else {
            return reply(with: "elementUnderCaret not found")
        }
        guard let typeElement = elementUnderCaret as? SwiftTypeElement,
            let inheritedType = typeElement.inheritedTypes.first else {
                return reply(with: "No inheritedType")
        }
        if let resolved = ResolveUtil().resolve(inheritedType) {
            let visitor = MethodGatheringVisitor()
            resolved.accept(RecursiveElementVisitor(visitor: visitor))
            return buildMock(methodNames: visitor.methodNames)
        } else {
            return reply(with: "\(inheritedType.name) element not found at: \(inheritedType.offset)")
        }
    }
    
    private static func reply(with message: String) -> ([String]?, Error?) {
        let nsError = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        return (nil, nsError)
    }
    
    private static func buildMock(methodNames: [String]) -> ([String]?, Error?) {
        var lines = [String]()
        for name in methodNames {
            lines.append("var invoked\(name.capitalized) = false")
            lines.append("var invoked\(name.capitalized)Count = 0")
            lines.append("func \(name)() {")
            lines.append("invoked\(name.capitalized) = true")
            lines.append("invoked\(name.capitalized)Count += 1")
            lines.append("}")
        }
        return (lines, nil)
    }
}
