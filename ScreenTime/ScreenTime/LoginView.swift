//
//  ContentView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 9/28/25.
//

import SwiftUI
import Supabase

struct LoginView: View {
    var onTapCreateAccount: () -> Void = {}
    var onSignInSuccess: () -> Void = {}
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var showPassword = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                VStack(spacing: 50) {
                    HStack {
                        Image("logo").resizable().scaledToFit().frame(height: 109)
                        Text(" pawse").font(.custom("Moulpali-Regular", size: 64))
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.075)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 320, height: 367)
                        .cornerRadius(8)
                        .overlay(
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Email").font(.custom("Moulpali-Regular", size: 16)).foregroundColor(.black)
                                TextField("Email", text: $email)
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .padding(.leading, 16)
                                    .frame(width: 272, height: 40, alignment: .leading)
                                    .background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                
                                Text("Password")
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.top, 12)
                                
                                ZStack(alignment: .trailing) {
                                    Group {
                                        if showPassword {
                                            TextField("Password", text: $password)
                                        } else {
                                            if password.isEmpty {
                                                SecureField("Password", text: $password)
                                            } else {
                                                SecureField("", text: $password)
                                                    .offset(y: 7)
                                            }
                                        }
                                    }
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .padding(.leading, 16)
                                    .frame(width: 272, height: 40, alignment: .leading)
                                    .background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))

                                    Button(action: { showPassword.toggle() }) {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 12)
                                    }
                                }
                                
                                Button(action: {
                                    Task { await signIn() }
                                }) {
                                    Text(isLoading ? "Signing in..." : "Sign In")
                                        .font(.custom("Moulpali-Regular", size: 16))
                                        .foregroundColor(.black)
                                        .frame(width: 272, height: 40)
                                        .background(Color(hex: "EBE3D7"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(6)
                                        .padding(.top, 17)
                                }
                                .disabled(isLoading)

                                ZStack(alignment: .topLeading) {
                                    if let errorMessage = errorMessage {
                                        Text(errorMessage)
                                            .font(.custom("Moulpali-Regular", size: 12))
                                            .foregroundColor(.red)
                                    }
                                }
                                .frame(height: 0)
                                .offset(y: 7.5)
                                
                                NavigationLink(destination: ForgotPasswordView()) {
                                    Text("Forgot password?")
                                        .font(.custom("Moulpali-Regular", size: 16))
                                        .underline()
                                        .foregroundColor(.black)
                                        .padding(.top, 9)
                                }
                                
                                NavigationLink(destination: RegisterView()) {
                                    Text("Don't have an account?")
                                        .font(.custom("Moulpali-Regular", size: 16))
                                        .underline()
                                        .foregroundColor(.black)
                                        .padding(.top, -5)
                                }
                            }
                                .padding(.top, 17.5)
                                .padding(.leading, 23.5),
                            alignment: .topLeading
                        )
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private struct UserRow: Decodable {
        let id: Int
        let email: String
        let password: String
    }

    private func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let client = SupabaseManager.shared.client

        do {
            let users: [UserRow] = try await client
                .from("users")
                .select("id,email,password")
                .eq("email", value: email)
                .eq("password", value: password)
                .limit(1)
                .execute()
                .value

            if users.isEmpty {
                errorMessage = "Incorrect email or password."
                return
            }

            errorMessage = nil
            onSignInSuccess()

        } catch {
            print("Login error:", error)
            errorMessage = "Incorrect email or password."
        }
    }
}


#Preview {
        LoginView()
}

// Helper extension to use hex codes
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // skip leading #
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
