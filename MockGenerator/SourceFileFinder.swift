import Foundation

class SourceFileFinder {
    
    private let projectRoot: URL
    
    init(projectRoot: URL) {
        self.projectRoot = projectRoot
    }
    
    func findSourceFiles() -> [String] {
        let enumerator = FileManager.default.enumerator(at: projectRoot, includingPropertiesForKeys: [.nameKey], options: .skipsHiddenFiles, errorHandler: nil)
        var files = [String]()
        while let file = enumerator?.nextObject() as? URL {
            if file.pathExtension == "swift" {
                files.append(file.path)
            }
        }
        return files
    }
}
