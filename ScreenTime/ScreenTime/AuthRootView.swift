//
//  AuthRootView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

enum AuthScreen { case login, register, home }

struct AuthRootView: View {
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
                HomeView()
            }
        }
        .animation(.easeInOut, value: screen)
    }
}
