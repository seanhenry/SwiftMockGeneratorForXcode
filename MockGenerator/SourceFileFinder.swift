import Foundation

class SourceFileFinder {
    
    private let projectRoot: URL
    
    init(projectRoot: URL) {
        self.projectRoot = projectRoot
    }
    
    func findSourceFiles() -> [URL] {
        let enumerator = FileManager.default.enumerator(at: projectRoot, includingPropertiesForKeys: [.nameKey], options: .skipsHiddenFiles, errorHandler: nil)
        var files = [URL]()
        while let file = enumerator?.nextObject() as? URL {
            if file.pathExtension == "swift" {
                files.append(file)
            }
        }
        return files
    }
}
