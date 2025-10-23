//
//  ScreenTimeManager.swift
//  ScreenTime
//
//  Created by Annie Jiang on 10/23/25.
//

// Using Apple Screen time APIs: FamilyControls,ManagedSettings,DeviceActivity
import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

@MainActor
final class ScreenTimeManager: ObservableObject {
    static let shared = ScreenTimeManager()
    private let store = ManagedSettingsStore()

    @Published var selection = FamilyActivitySelection()

    func requestAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                print("Screen Time authorization success")
            } catch {
                print("Failed to get authorization: \(error)")
            }
        }
    }

    func startBlocking() {
        // Block whatever the user picked in the FamilyActivityPicker
        store.shield.applications = selection.applicationTokens
        store.shield.webDomains = selection.webDomainTokens

        print("Block session start")
    }

    func stopBlocking() {
        store.shield.applications = nil
        store.shield.webDomains = nil
        store.shield.applicationCategories = nil

        print("Block session stop")
    }
}
