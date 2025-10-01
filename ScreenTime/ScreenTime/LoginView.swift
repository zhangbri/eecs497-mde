//
//  ContentView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 9/28/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(hex: "EBE3D7")
                .ignoresSafeArea()
            VStack(spacing: 60) {
                HStack() {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 64)
                    Text("pawse")
                        .font(.system(size: 64, weight: .regular, design: .rounded))
                }
                .padding(.top, UIScreen.main.bounds.height * 0.075)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 320, height: 367)
                    .cornerRadius(8)
                    .overlay(
                        VStack(alignment: .leading, spacing: 12) {
                            // Label
                            Text("Email")
                                .font(.system(size: 16))
                                .foregroundColor(.black)

                            TextField("Email", text: .constant(""))
                                .font(.system(size: 16))
                                .padding(.leading, 16)
                                .frame(width: 272, height: 40, alignment: .leading)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            
                            Text("Password")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(.top, 12)
        
                            TextField("Password", text: .constant(""))
                                .font(.system(size: 16))
                                .padding(.leading, 16)
                                .frame(width: 272, height: 40, alignment: .leading)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            Button(action: {
                                print("Sign In tapped")
                            }) {
                                Text("Sign In")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .frame(width: 272, height: 40)
                                    .background(Color(hex: "EBE3D7"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                    .cornerRadius(6)
                                    .padding(.top, 9)
                            }
                            Button(action: {
                                print("Forgot password tapped")
                            }) {
                                Text("Forgot password?")
                                    .font(.system(size: 16))
                                    .underline()
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 13)

                            Button(action: {
                                print("Don't have an account tapped")
                            }) {
                                Text("Don't have an account?")
                                    .font(.system(size: 16))
                                    .underline()
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 4)
                        }
                        .padding(.top, 25)
                            .padding(.leading, 23.5),
                        alignment: .topLeading
                        
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
            }
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
        
        self.init(red: r, green: g, blue: b)
    }
}
