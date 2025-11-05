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
    var body: some Scene {
        WindowGroup {
            AuthRootView()
                .environmentObject(router)
        }
    }
}

