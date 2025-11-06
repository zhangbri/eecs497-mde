//
//  AuthRootView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

enum AuthScreen { case login, register, home }

struct AuthRootView: View {
    @EnvironmentObject private var router: TabRouter
    @State private var screen: AuthScreen = .login

    var body: some View {
        Group {
            switch screen {
            case .login:
                LoginView(
                    onTapCreateAccount: { screen = .register },
                    onSignInSuccess: { screen = .home }
                )
            case .register:
                RegisterView(onTapAlreadyHaveAccount: { screen = .login })
            case .home:
                switch router.tab {
                case .home:        HomeView()
                case .inventory:   InventoryView()
                case .shop:        GachaView()
                case .leaderboard: LeaderboardView()
                case .profile:     ProfileView()
                }
            }
        }
        .animation(.easeInOut, value: screen)
        .animation(.easeInOut, value: router.tab)
    }
}
