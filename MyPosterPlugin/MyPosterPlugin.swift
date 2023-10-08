//
//  MyPosterPlugin.swift
//  MyPosterPlugin
//
//  Created by Jinwoo Kim on 10/8/23.
//

import SwiftUI
import Foundation
import ExtensionKit

actor MyPosterPluginConfiguration: AppExtensionConfiguration {
    nonisolated func accept(connection: NSXPCConnection) -> Bool {
        true
    }
}

@main
struct MyPosterPlugin: AppExtension {
    var configuration: AppExtensionSceneConfiguration {
        let configuration: MyPosterPluginConfiguration = .init()
        
        return .init(
            PrimitiveAppExtensionScene(
                id: "com.pookjw.MyPoster.MyPosterPlugin",
                content: {
                    Text("Hello World!")
                },
                onConnection: { connection in
                    connection.activate()
                    return true
                }
            ),
            configuration: configuration
        )
    }
    
    init() {
        
    }
}
