//
//  LeaderboardView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct LeaderboardView: View {
    @AppStorage("coins") private var coins: Int = 0
        @State private var selectedTab: PawseTab = .inventory
        private let barHeight: CGFloat = 78

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
                                                .offset(x: -8)
                                        }
                                    }
                                    .offset(x: -15)
                                }
                                .padding(.leading, 15)
                                ZStack {
                                    Text("Leaderboard")
                                        .font(.custom("Moulpali-Regular", size: 48))
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            print("Back arrow tapped")
                                        }) {
                                            Image("leftarrow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 48, height: 48)
                                        }
                                        .padding(.leading, -5)

                                        Image("friends")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 48, height: 48)
                                            .offset(x:-20)
                                    }
                                    .padding(.leading, 0),
                                    alignment: .leading
                                )
                                .offset(y: -35)
                                Text("Week of: 9/28-10/4")
                                    .font(.custom("Moulpali-Regular", size: 24))
                                    .offset(y: -60)
                                
                                HStack(alignment: .bottom, spacing: 15) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 120, height: 150)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            VStack {
                                                ZStack(alignment: .topTrailing) {
                                                                    Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 63, height: 63)
                                                .foregroundColor(Color(hex: "FFFFFF"))
                                                Image("2nd")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 54, height: 54)
                                                .offset(x: 24, y: -8)
                                                                }
                                                                .offset(y: 40)
                                                Text("User")
                                                    .font(.custom("Moulpali-Regular", size: 30))
                                                Text("6h 7m")
                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                    .offset(y:-25)
                                            }
                                        )

                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 155, height: 200)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            VStack {
                                                ZStack(alignment: .topTrailing) {
                                                                    Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(Color(hex: "FFFFFF"))
                                                Image("1st")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 62, height: 62)
                                                .offset(x: 30, y: -8)
                                                                }
                                                                .offset(y: 35)
                                                Text("User")
                                                    .font(.custom("Moulpali-Regular", size: 30))
                                                Text("6h 7m")
                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                    .offset(y:-25)
                                            }
                                        )

                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 110, height: 150)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            VStack {
                                                ZStack(alignment: .topTrailing) {
                                                                    Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 63, height: 63)
                                                .foregroundColor(Color(hex: "FFFFFF"))
                                                Image("3rd")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 53, height: 53)
                                                .offset(x: 24, y: -8)
                                                                }
                                                    .offset(y:40)
                                                Text("User")
                                                    .font(.custom("Moulpali-Regular", size: 30))
                                                Text("6h 7m")
                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                    .offset(y:-25)
                                            }
                                        )
                                }
                                .offset(y:-85)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "F2EDE7"))
                                    .frame(width: 368, height: 73)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    .overlay(
                                        HStack {
                                            Text("4.")
                                                .font(.custom("Moulpali-Regular", size: 30))
                                            .padding(.leading, -58)
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 54, height: 54)
                                                .foregroundColor(Color(hex: "FFFFFF"))
                                                .offset(x: -20)
                                            Text("User")
                                                .font(.custom("Moulpali-Regular", size: 30))
                                            Text("4 hrs 28 min.")
                                                .font(.custom("Moulpali-Regular", size: 16))
                                                .offset(x: 58)
                                        }
                                    )
                                    .offset(y: -35)

                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "F2EDE7"))
                                    .frame(width: 368, height: 73)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    .overlay(
                                        HStack {
                                            Text("5.")
                                                .font(.custom("Moulpali-Regular", size: 30))
                                                .padding(.leading, -58)
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 54, height: 54)
                                                .foregroundColor(Color(hex: "FFFFFF"))
                                                .offset(x: -20)
                                            Text("User")
                                                .font(.custom("Moulpali-Regular", size: 30))
                                            Text("3 hrs 10 min.")
                                                .font(.custom("Moulpali-Regular", size: 16))
                                                .offset(x: 58)
                                        }
                                    )
                                    .offset(y: -10)
                                Button(action: {
                                    print("Invite button tapped!")
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(hex: "80CCDD"))
                                            .frame(width: 147, height: 40)
                                            .overlay(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.black, lineWidth: 1)
                                                        )
                                        Text("Invite your friends!")
                                            .foregroundColor(.white)
                                            .font(.custom("Moulpali-Regular", size: 16))
                                            .foregroundColor(.black)
                                    }
                                    .offset(y: 45)
                                }

                            }
                        }
                    }
                    BottomNavBar(selection: $selectedTab) { _ in }
                        .frame(height: barHeight)
                        .background(Color(hex: "EBE3D7"))
                        .ignoresSafeArea(edges: .bottom)
                        .offset(y: 34)
                }
            }
        }
}

#Preview {
    LeaderboardView()
}
