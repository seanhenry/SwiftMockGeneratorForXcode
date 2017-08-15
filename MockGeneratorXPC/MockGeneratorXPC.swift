//
//  MockGeneratorXPC.swift
//  MockGenerator
//
//  Created by Sean Henry on 12/08/2017.
//  Copyright © 2017 Sean Henry. All rights reserved.
//

import Foundation
import SourceKittenFramework

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {
    
    var message = ""
    var args: [String]!
    var lines = [String]()
    var error = ""
    
    func generateMock(fromFileContents contents: String, projectURL: URL, withReply reply: @escaping ([String]?, Error?) -> Void) {
        
        let files = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        args = [
            "-Onone",
            "-sdk",
            "/Applications/Xcode-8.3.2.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk",
            "-enable-testing",
            "-j4",
            ] + files.map { projectURL.appendingPathComponent($0).absoluteString }
        message = ""
        error = ""
        lines = []
        printProtocol()
        args.append(message)
        var nsError: Error?
        if !error.isEmpty {
            nsError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error])
        }
        reply(lines, nsError)
    }
    
    func print(_ message: String) {
        self.message += message + "\n"
    }
    
    func printProtocol() {
        let result = Request.cursorInfo(file: "/Users/sean/source/plugins/xcodeTestProject/MockSimpleProtocol.swift", offset: 61, arguments: args)
            .send()
        guard let filepath = result["key.filepath"] as? String else {
            error = "key.filepath not found \(result)"
            return;
        }
        let structure = Structure(file: File(path: filepath)!).dictionary
        let protocols = findProtocols(structure)
        protocols.forEach { p in
            lines.append("@testable import MockTestProject")
            lines.append("")
            lines.append("class MockSimpleProtocol: SimpleProtocol {")
            lines.append("")
            let methods = findMethods(p)
            methods.forEach { m in
                print("method: \(getName(m))")
                let name = getName(m)
                let invokedName = "invoked" + name.capitalized
                lines.append("    var \(invokedName) = false")
                lines.append("")
                lines.append("    func \(name)() {")
                lines.append("        \(invokedName) = true")
                lines.append("    }")
//                findParameters(m).forEach { p in
//                    print("parameter: \(getName(p)): \(getType(p))")
//                    let offset = getParameterTypeOffset(p)
//                    let parameterResult = Request.cursorInfo(file: filepath, offset: offset, arguments: args)
//                        .send()
//                    print("Resolved:" + (parameterResult["key.name"] as! String))
//                }
            }
            lines.append("}")
        }
    }
    
    private func findProtocols(_ structure: [String: SourceKitRepresentable]) -> [[String: SourceKitRepresentable]] {
        guard let substructure = structure["key.substructure"] as? [[String: SourceKitRepresentable]] else {
            return []
        }
        return substructure.filter { $0["key.kind"] as? String == "source.lang.swift.decl.protocol" }
    }
    
    private func findMethods(_ protocol: [String: SourceKitRepresentable]) -> [[String: SourceKitRepresentable]] {
        guard let substructure = `protocol`["key.substructure"] as? [[String: SourceKitRepresentable]] else {
            return []
        }
        return substructure.filter { $0["key.kind"] as? String == "source.lang.swift.decl.function.method.instance" }
    }
    
    private func findParameters(_ method: [String: SourceKitRepresentable]) -> [[String: SourceKitRepresentable]] {
        guard let substructure = method["key.substructure"] as? [[String: SourceKitRepresentable]] else {
            return []
        }
        return substructure.filter { $0["key.kind"] as? String == "source.lang.swift.decl.var.parameter" }
    }
    
    private func getName(_ any: [String: SourceKitRepresentable]) -> String {
        return (any["key.name"] as? String)?.replacingOccurrences(of: "()", with: "") ?? "unknown"
    }
    
    private func getType(_ any: [String: SourceKitRepresentable]) -> String {
        return (any["key.typename"] as? String) ?? "unknown"
    }
    
    private func getParameterTypeOffset(_ any: [String: SourceKitRepresentable]) -> Int64 {
        guard let nameOffset = any["key.nameoffset"] as? Int64,
            let nameLength = any["key.namelength"] as? Int64 else {
                return 0
        }
        return nameOffset + nameLength + 2 // 2 = colon + space
    }
}
