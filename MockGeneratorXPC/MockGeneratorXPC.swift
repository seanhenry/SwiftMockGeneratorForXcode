//
//  MockGeneratorXPC.swift
//  MockGenerator
//
//  Created by Sean Henry on 12/08/2017.
//  Copyright © 2017 Sean Henry. All rights reserved.
//

import Foundation
import SourceKittenFramework
@testable import SwiftStructureInterface

@objc class MockGeneratorXPC: NSObject, MockGeneratorXPCProtocol {
    
    func generateMock(fromFileContents contents: String, projectURL: URL, line: Int, column: Int, withReply reply: @escaping ([String]?, Error?) -> Void) {
        
        // TODO: put files elsewhere
        ResolveUtil.files = SourceFileFinder(projectRoot: projectURL).findSourceFiles()
        // TODO: fully encapsulate SourceKitten
        let structure = Structure(file: File(contents: contents))
        let element = StructureBuilder(data: structure.dictionary, text: contents).build()
        guard let cursorOffset = LocationConverter.convert(line: line, column: column, in: contents) else {
            self.reply(with: "cursor not found", reply: reply)
            return
        }
        guard let elementUnderCaret = CaretUtil().findElementUnderCaret(in: element, cursorOffset: cursorOffset) else {
            self.reply(with: "elementUnderCaret not found", reply: reply)
            return
        }
        guard let typeElement = elementUnderCaret as? SwiftTypeElement,
              let inheritedType = typeElement.inheritedTypes.first else {
            self.reply(with: "No inheritedType", reply: reply)
            return
        }
        let resolved = ResolveUtil().resolve(inheritedType)
        if let resolved = resolved {
            self.reply(with: "\(inheritedType.name) element resolved: \(resolved.name) at: \(inheritedType.offset)", reply: reply)
        } else {
            self.reply(with: "\(inheritedType.name) element not found at: \(inheritedType.offset)", reply: reply)
        }
    }
    
    private func reply(with message: String, reply: ([String]?, Error?) -> Void) {
        let nsError = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : message])
        reply(nil, nsError)
    }
}
