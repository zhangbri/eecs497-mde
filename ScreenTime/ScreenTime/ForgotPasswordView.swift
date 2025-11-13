//
//  ForgotPasswordView.swift
//  ScreenTime
//
//  Created by Annie Jiang on 11/13/25.
//
import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var didSendEmail = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(hex: "EBE3D7").ignoresSafeArea()
            
            if didSendEmail {
                ConfirmationView()
            } else {
                ForgotPasswordForm(email: $email, didSendEmail: $didSendEmail)
            }
        }
    }
}

struct ForgotPasswordForm: View {
    @Binding var email: String
    @Binding var didSendEmail: Bool
    
    var body: some View {
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
                    .frame(width: 320, height: 220)
                    .cornerRadius(8)
                    .overlay(
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Enter your email")
                                .font(.custom("Moulpali-Regular", size: 18))
                                .foregroundColor(.black)
                            
                            TextField("Email", text: $email)
                                .font(.custom("Moulpali-Regular", size: 16))
                                .padding(.leading, 16)
                                .frame(width: 272, height: 40, alignment: .leading)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                            
                            Button(action: {
                                print("Reset link sent")
                                didSendEmail = true
                            }) {
                                Text("Send Reset Link")
                                    .font(.custom("Moulpali-Regular", size: 16))
                                    .foregroundColor(.black)
                                    .frame(width: 272, height: 40)
                                    .background(Color(hex: "EBE3D7"))
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
                                    .cornerRadius(6)
                                    .padding(.top, 10)
                            }
                        }
                            .padding(.top, 25)
                            .padding(.leading, 23.5),
                        alignment: .topLeading
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ConfirmationView: View {
    var body: some View {
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
                    .frame(width: 320, height: 200)
                    .cornerRadius(8)
                    .overlay(
                        VStack(spacing: 20) {
                            Text("Password reset link sent.")
                                .font(.custom("Moulpali-Regular", size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}

