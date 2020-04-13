import Foundation
import Formatter
import SwiftyKit
import class Resolver.ResolverFactory
import ASTSerialize
import SwiftyServiceImpl

public func setUpSwifty(projectURL: URL, useTabs: Bool, indentationWidth: Int) {
    let sourceFiles = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
    resolverFactory = .init {
        ResolverFactory.createResolver(filePaths: filterUniqueFileNames(sourceFiles))
    }
    formatterFactory = FormatterFactory {
        DefaultFormatter(useTabs: useTabs, indentationWidth: indentationWidth)
    }
    makeService = { SwiftyServiceImpl() }
    makeDeserializer = { ASTDeserializer() }
    parserFactory = ParserFactory { PositionParser() }
}

private func filterUniqueFileNames(_ fileNames: [URL]) -> [String] {
    var sourceFileSet = Set<String>()
    return fileNames.map { file in
        (file.path, file.lastPathComponent)
    }.compactMap { (file, name) in
        if sourceFileSet.contains(name) {
            return nil
        }
        sourceFileSet.insert(name)
        return file
    }
}
