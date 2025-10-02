//
//  ScreenTimeApp.swift
//  ScreenTime
//
//  Created by Brian Zhang on 9/28/25.
//

import SwiftUI

@main
struct ScreenTimeApp: App {
    var body: some Scene {
        WindowGroup {
            AuthRootView() // no NavigationStack needed for this toggle
        }
    }
}
