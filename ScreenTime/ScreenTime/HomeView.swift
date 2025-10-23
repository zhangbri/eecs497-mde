//
//  HomeView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showingBlocking = false
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            Image("graycat")
                .resizable()
                .scaledToFit()
                .frame(width: 318, height: 318)
                .offset(y: -160)
            
            Text("0h 0m")
                .font(.custom("Moulpali-Regular", size: 65))
                .foregroundColor(.black)
                .offset(y: 25)
            Text("hours saved")
                .font(.custom("Sarabun-Thin", size: 30))
                .foregroundColor(.black)
                .offset(y: 70)
            Button(action: {
                showingBlocking = true
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "646E61"))
                    .frame(width: 235, height: 49)
                    .overlay(
                        Text("start session")
                            .font(.custom("Sarabun-Regular", size: 20))
                            .foregroundColor(.white)
                    )
            }
            .offset(y: 125)
            VStack {
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 49)
                    Text("pawse")
                        .font(.custom("Moulpali-Regular", size: 30))
                    Spacer()
                }
                .padding(.leading, 15)
                
                Spacer()
            }
            if showingBlocking {
                            ZStack {
                                Color(hex: "EBE3D7").ignoresSafeArea()  // same as homescreen

                                VStack(spacing: 24) {
                                    // simple top bar with back button (optional)
                                    HStack {
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                showingBlocking = false
                                            }
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.black)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 8)
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 8)
                                    .padding(.horizontal, 8)

                                    Spacer()

                                    // the “big rectangle + inner rectangles” content
                                    BlockingSetupContent(
                                        onBegin: { print("Begin blocking tapped") }
                                    )

                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1) // ensure above homescreen
                        }
        }
    }
}

private struct BlockingSetupContent: View {
    var onBegin: () -> Void

    var body: some View {
        // Big white container
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(width: 340, height: 240)
            .overlay(
                VStack(spacing: 18) {
                    HStack(spacing: 25) {
                        // FROM
                        VStack(spacing: 6) {
                            Text("from")
                                .font(.custom("Sarabun-Regular", size: 16))
                                .foregroundColor(.black)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 120, height: 60)
                                .overlay(
                                    Text("12:00am")
                                        .font(.custom("Moulpali-Regular", size: 28))
                                        .foregroundColor(.black)
                                )
                                .overlay( // subtle border instead of shadow
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.12), lineWidth: 1)
                                )
                        }
                        // TO
                        VStack(spacing: 6) {
                            Text("to")
                                .font(.custom("Sarabun-Regular", size: 16))
                                .foregroundColor(.black)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 120, height: 60)
                                .overlay(
                                    Text("6:07am")
                                        .font(.custom("Moulpali-Regular", size: 28))
                                        .foregroundColor(.black)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.12), lineWidth: 1)
                                )
                        }
                    }

                    Text("6h 7m of blocking")
                        .font(.custom("Sarabun-Regular", size: 16))
                        .foregroundColor(.black)

                    Button(action: onBegin) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "646E61"))
                            .frame(width: 200, height: 45)
                            .overlay(
                                Text("begin blocking")
                                    .font(.custom("Sarabun-Regular", size: 18))
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.top, 2)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            )
            .overlay( // subtle container border
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
    }
}


#Preview {
    HomeView()
}
