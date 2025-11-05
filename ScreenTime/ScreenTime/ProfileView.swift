//
//  ProfileView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: TabRouter
    private let gridCols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @AppStorage("coins") private var coins: Int = 0
    private let barHeight: CGFloat = 78

    @State private var name: String = ""
    @State private var username: String = ""
    @State private var pronouns: String = ""
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                ScrollView(.vertical) {
                    ZStack {
                        VStack {
                            HStack {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 49)
                                Text("pawse")
                                    .font(.custom("VictorMono-Regular", size: 30))
                                    .foregroundColor(.black)
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 110, height: 49)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    HStack {
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 51, height: 51)
                                            .offset(x: 5, y: 1)
                                        Text("\(coins)")
                                            .font(.custom("Moulpali-Regular", size: 25))
                                            .frame(width: 60, alignment: .center)
                                            .multilineTextAlignment(.center)
                                            .offset(x: -8)
                                    }
                                }
                                .offset(x: -15, y: 0)
                            }
                            .padding(.leading, 15)
                            Text("Profile")
                                .font(.custom("Moulpali-Regular", size: 48))
                                .offset(y: -70)
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 205, height: 205)
                                .foregroundColor(Color(hex: "FFFFFF"))
                                .padding(.top, -170)
                            Text("edit profile picture")
                                .font(.custom("Sarabun-Light", size: 16))
                                .padding(.top, 4)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            VStack() {
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                HStack {
                                    Text("Name").font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Name", text: $name)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 48)
                                    
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                HStack {
                                    Text("Username")
                                        .font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Username", text: $username)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 9.5)
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                HStack {
                                    Text("Pronouns")
                                        .font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Pronouns", text: $pronouns)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 15.5)
                                
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                            }
                            .padding(.top,7.5)
                            Text("Achievement")
                                .font(.custom("Moulpali-Regular", size: 48))
                                .offset(y: -65)
                            VStack {
                                LazyVGrid(columns: gridCols, spacing: 30) {
                                    ForEach(0..<6, id: \.self) { i in
                                        achievementCard {
                                            Image(systemName: "trophy.fill")
                                                .font(.system(size: 45))
                                                .foregroundColor(.black.opacity(0.5))
                                        }
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                            .offset(y: -155)
                            Spacer()
                        }
                    }
                    
                    .padding(.bottom, -80)
                }
                BottomNavBar(selection: $router.tab) { _ in }
                        .frame(height: barHeight)
                        .background(Color(hex: "EBE3D7"))
                        .ignoresSafeArea(edges: .bottom)
                        .offset(y: 34)
            }
        }
    }
}
@ViewBuilder
private func achievementCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    RoundedRectangle(cornerRadius: 20)
        .fill(Color(hex: "F2EDE7"))
        .frame(width: 110, height: 110)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        .overlay(content())
}

#Preview {
    ProfileView()
}
