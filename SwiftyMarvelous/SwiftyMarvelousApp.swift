//
//  SwiftyMarvelousApp.swift
//  SwiftyMarvelous
//
//  Created by Alex Thurston on 7/18/23.
//

import SwiftUI

@main
struct SwiftyMarvelousApp: App {
    
    @StateObject private var container = Container()
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}
