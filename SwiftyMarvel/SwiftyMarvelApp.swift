//
//  SwiftyMarvelApp.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 05/07/2023.
//

import SwiftUI

@main
struct SwiftyMarvelApp: App {
    
    init() {
        /// Injecting all dependencies
        Resolver.shared.injectModules()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
