//
//  SourceEditorExtension.swift
//  XcodePlugin
//
//  Created by Sean Henry on 12/08/2017.
//  Copyright © 2017 Sean Henry. All rights reserved.
//

import Foundation
import XcodeKit
import Cocoa

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
//        let workspaceWindowControllers = NSClassFromString("IDEWorkspaceWindowController")?.value(forKey: "workspaceWindowControllers") as? [Any]
//        let workspaceController = workspaceWindowControllers?.first { controller in
//            return controller.value(forKey: "window") == NSApp.keyWindow
//        }
//        let workspace = workspaceController?.value(forKey: "_workspace")
//        print(workspace)
//        let workspacePath = workSpace?.value(forKey: "representingFilePath")?.value(forKey: "_pathString")
//        print(workspacePath)
    }
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
}
