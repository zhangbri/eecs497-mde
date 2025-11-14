//
//  SupabaseManager.swift
//  ScreenTime
//
//  Created by Andy Pan on 11/14/25.
//

import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://udtdzibewjrtxmswmzjx.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkdGR6aWJld2pydHhtc3dtemp4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEyMzE1NDYsImV4cCI6MjA3NjgwNzU0Nn0.NvaFu50KouZU4dW5vIikg2nHN-UOYJ2WU18kl4aXd6k"
        )
    }
}
