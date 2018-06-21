public class ResolverFactory {

    private init() {}

    public static func createResolver(filePaths: [String]) -> Resolver {
        let fileWriter = TempFileWriterUtil()
        let manyFileResolver = SKResolver(nil, cursorInfoRequest: SKCursorInfoRequest(files: filePaths), fileWriter: fileWriter)
        let sameFileResolver = SKResolver(manyFileResolver, cursorInfoRequest: SKCursorInfoRequest(files: []), fileWriter: fileWriter)
        let writeToFile = WriteFileResolver(sameFileResolver, fileWriter: fileWriter)
        let cachingResolver = CachingResolver(writeToFile)
        return LocalResolver(cachingResolver)
    }
}
