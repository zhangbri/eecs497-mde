//
//  InventoryView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

private enum InventoryTab: String, CaseIterable {
    case sprites, items, eggs
}

struct InventoryView: View {
    @EnvironmentObject private var router: TabRouter
    @AppStorage("coins") private var coins: Int = 0
    @State private var invTab: InventoryTab = .sprites
    private let gridCols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

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
                            Image("egg")
                                .offset(y: -40)
                            Text("Epic Egg")
                            .font(.custom("Moulpali-Regular", size: 35))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .offset(y: -85)
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(hex: "C4C5C7"))
                                .frame(width: 300, height: 20)
                                .offset(y: -155)
                            Text("0% hatched")
                            .font(.custom("Sarabun-Medium", size: 25))
                            .offset(y: -150)
                            Text("2 session hours until hatched")
                            .font(.custom("Sarabun-Thin", size: 20))
                            .offset(y: -145)
                            
                            ZStack(alignment: .top) {
                                VStack {
                                    HStack(spacing: 0) {
                                        ForEach(InventoryTab.allCases, id: \.self) { tab in
                                            Button {
                                                invTab = tab
                                            } label: {
                                                Text(tab.rawValue)
                                                    .font(.custom("Sarabun-Light", size: 30))
                                                    .foregroundColor(.black)
                                                    .offset(y: -12.5)
                                                    .frame(maxWidth: .infinity, minHeight: 80)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .fill(invTab == tab ? Color(hex: "F5F5F5") : Color(hex: "F2EDE7"))
                                                    )
                                                    .clipShape(
                                                        UnevenRoundedRectangle(cornerRadii: .init(
                                                            topLeading: 20,
                                                            bottomLeading: 0,
                                                            bottomTrailing: 0,
                                                            topTrailing: 20
                                                        ))
                                                    )
                                                    .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: -2)
                                                
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                panel(for: invTab)
                                .offset(y: 52.5)
                                .padding(.bottom, -51)
                            }
                            .offset(y: -148)
                        }
                    }

                }
                BottomNavBar(selection: $router.tab) { _ in }
                    .frame(height: barHeight)
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 34)
            }
        }
    }
    @ViewBuilder
    private func panel(for tab: InventoryTab) -> some View {
        VStack {
            switch tab {
            case .sprites:
                gridPanel {
                    ForEach(0..<6, id: \.self) { i in
                        inventoryCard {
                            if i == 0 { Image("sprite_cat").resizable().scaledToFit().padding(14) }
                        }
                    }
                }
            case .items:
                gridPanel {
                    ForEach(0..<6, id: \.self) { _ in
                        inventoryCard {
                            Image(systemName: "gift")
                                .font(.system(size: 55))
                                .foregroundColor(.black.opacity(0.6))
                        }
                    }
                }
            case .eggs:
                gridPanel {
                    ForEach(0..<6, id: \.self) { _ in
                        inventoryCard {
                            Image("egg").resizable().scaledToFit().padding(18)
                        }
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 30)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "F5F5F5"))
    }
    private func gridPanel<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        LazyVGrid(columns: gridCols,  spacing: 30) { content() }
            .padding(.horizontal, 10)
      
    }

    private func inventoryCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 110, height: 110)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay(content())
    }

}
#Preview {
    InventoryView().environmentObject(TabRouter())
}
