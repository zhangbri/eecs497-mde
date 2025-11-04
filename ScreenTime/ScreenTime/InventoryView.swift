//
//  InventoryView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct InventoryView: View {
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
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: proxy.size.height)
                        .padding(.bottom, 25)
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
    InventoryView()
}
