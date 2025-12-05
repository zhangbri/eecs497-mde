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
    @StateObject private var inventory = InventoryModel()

    init() {
        #if DEBUG

        UserDefaults.standard.set(9000, forKey: "coins")
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            AuthRootView()
                .environmentObject(router)
                .environmentObject(inventory)    
        }
    }
}

