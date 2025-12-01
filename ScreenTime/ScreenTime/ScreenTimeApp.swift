//
//  ScreenTimeApp.swift
//  ScreenTime
//
//  Created by Brian Zhang on 9/28/25.
//

import SwiftUI

@main
struct ScreenTimeApp: App {
    @StateObject private var router = TabRouter()
    
    init() {
        UserDefaults.standard.register(defaults: [
            "coins": 2000
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            AuthRootView()
                .environmentObject(router)
        }
    }
}

