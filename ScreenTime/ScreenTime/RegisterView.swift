//
//  ContentView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 9/28/25.
//

import SwiftUI
import Supabase

struct RegisterView: View {
    var onTapAlreadyHaveAccount: () -> Void = {}
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading = false

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
                        .frame(width: 320, height: 332)
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
                                
                                Text("Password")
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.top, 12)
                                
                                TextField("Password", text: $password)
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .padding(.leading, 16)
                                    .frame(width: 272, height: 40, alignment: .leading)
                                    .background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                                
                                Button(action: {
                                    Task { await register() }
                                }) {
                                    Text(isLoading ? "Registering..." : "Register")
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
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .font(.custom("Moulpali-Regular", size: 8))
                                        .padding(.top, 5)
                                }
                                NavigationLink(destination: LoginView()) {
                                    Text("Already have an account?")
                                        .font(.custom("Moulpali-Regular", size: 16))
                                        .underline()
                                        .foregroundColor(.black)
                                        .padding(.top, 9)
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
    
    private struct ExistingUser: Decodable {
        let id: Int
    }

    private struct NewUser: Encodable {
        let email: String
        let username: String
        let password: String
        let sprite_id: Int?
        let total_points: Int
        let total_hours: Int
        let friends: [String]?
    }
    
    private func register() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill out all fields."
            return
        }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let client = SupabaseManager.shared.client

        do {
            let existingUsers: [ExistingUser] = try await client
                .from("users")
                .select("id")
                .eq("email", value: email)
                .execute()
                .value

            if !existingUsers.isEmpty {
                errorMessage = "User already exists with this email."
                return
            }


            _ = try await client.auth.signUp(
                email: email,
                password: password
            )

            let username = email.split(separator: "@").first.map(String.init) ?? email

            let newUser = NewUser(
                email: email,
                username: username,
                password: password,
                sprite_id: nil,
                total_points: 0,
                total_hours: 0,
                friends: []
            )

            try await client
                .from("users")
                .insert(newUser)
                .execute()

            dismiss()

        } catch {
            print("Register error:", error)
            errorMessage = error.localizedDescription
        }
    }
}
    


#Preview {
    RegisterView()
}
