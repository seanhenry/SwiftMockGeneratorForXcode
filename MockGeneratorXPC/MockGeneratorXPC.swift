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
    func test(_ completion: ((String?) -> Void)!) {
        message = ""
        printProtocol()
        completion(message)
    }
    
    var message = ""
    let dir = "/Users/sean/source/temp/SourceKitTest/SourceKitTest"
    var protocolPath: String { return dir + "/Protocol.swift" }
    var path: String { return dir + "/MockProtocol.swift" }
    let args: [String] = [
//        "-module-name",
//        "Test",
        "-Onone",// Will this improve performance?
//        "-DDEBUG",
        "-sdk",
        "/Applications/Xcode-8.3.2.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk",
//        "-target",
//        "x86_64-apple-macosx10.12",
//        "-g",
//        "-module-cache-path",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/ModuleCache",
//        "-Xfrontend",
//        "-serialize-debugging-options",
//        "-enable-testing",
//        "-Xcc",
//        "-I",
//        "-Xcc",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Products/Debug",
//        "-I",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Products/Debug",
//        "-Xcc",
//        "-F",
//        "-Xcc",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Products/Debug",
//        "-F",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Products/Debug",
//        "-c",
        "-j4",
        "/Users/sean/source/temp/SourceKitTest/Test/ViewController.swift",
        "/Users/sean/source/temp/SourceKitTest/SourceKitTest/MockProtocol.swift",
        "/Users/sean/source/temp/SourceKitTest/Test/AppDelegate.swift",
        "/Users/sean/source/temp/SourceKitTest/SourceKitTest/Protocol.swift",
//        "-emit-module",
//        "-emit-module-path",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Objects-normal/x86_64/Test.swiftmodule",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/swift-overrides.hmap",
//        "-Xcc",
//        "-iquote",
//        "-Xcc",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Test-generated-files.hmap",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Test-own-target-headers.hmap",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Test-all-target-headers.hmap",
//        "-Xcc",
//        "-iquote",
//        "-Xcc",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Test-project-headers.hmap",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Products/Debug/include",
//        "-Xcc",
//        "-ISourceKitTest/lib/SourceKittenFramework.framework",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/DerivedSources/x86_64",
//        "-Xcc",
//        "-I/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/DerivedSources",
//        "-Xcc",
//        "-DDEBUG=1",
//        "-emit-objc-header",
//        "-emit-objc-header-path",
//        "/Users/sean/Library/Developer/Xcode/DerivedData/SourceKitTest-azlyrlpainvikkgvxsaikyagdvrg/Build/Intermediates/SourceKitTest.build/Debug/Test.build/Objects-normal/x86_64/Test-Swift.h",
//        "-Xcc",
//        "-working-directory/Users/sean/source/temp/SourceKitTest"
    ]
    
    func print(_ message: String) {
        self.message += message + "\n"
    }
    
    func printProtocol() {
        let result = Request.cursorInfo(file: "/Users/sean/source/temp/SourceKitTest/SourceKitTest/MockProtocol.swift", offset: 186, arguments: args)
            .send()
        let filepath = result["key.filepath"] as! String
        let structure = Structure(file: File(path: filepath)!).dictionary
        let protocols = findProtocols(structure)
        protocols.forEach { p in
            let methods = findMethods(p)
            methods.forEach { m in
                print("method: \(getName(m))")
                findParameters(m).forEach { p in
                    print("parameter: \(getName(p)): \(getType(p))")
                    let offset = getParameterTypeOffset(p)
                    let parameterResult = Request.cursorInfo(file: filepath, offset: offset, arguments: args)
                        .send()
                    print("Resolved:" + (parameterResult["key.name"] as! String))
                }
            }
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
        return (any["key.name"] as? String) ?? "unknown"
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
