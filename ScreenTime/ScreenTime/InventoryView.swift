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
    @EnvironmentObject private var inventory: InventoryModel
    @AppStorage("coins") private var coins: Int = 0
    @AppStorage("stats_total_minutes") private var totalSessionMinutes: Int = 0
    
    @State private var invTab: InventoryTab = .sprites
    private let gridCols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    private let barHeight: CGFloat = 78
    private let hatchGoalMinutes: Int = 120

    private var hatchProgress: Double {
        guard hatchGoalMinutes > 0 else { return 0 }
        let raw = Double(totalSessionMinutes) / Double(hatchGoalMinutes)
        return min(max(raw, 0), 1) // clamp 0...1
    }

    private var hatchPercentText: String {
        let percent = Int(hatchProgress * 100)
        return "\(percent)% hatched"
    }

    private var hatchRemainingText: String {
        let remaining = max(hatchGoalMinutes - totalSessionMinutes, 0)
        if remaining == 0 {
            return "Egg ready to hatch!"
        } else {
            return "\(remaining) session minutes until hatched"
        }
    }

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
                            Text("Plain Egg")
                            .font(.custom("Moulpali-Regular", size: 35))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .offset(y: -85)
                            // Progress bar: gray background + green fill on top
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(hex: "C4C5C7"))

                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(hex: "548777"))
                                    .frame(width: 300 * CGFloat(hatchProgress))
                            }
                            .frame(width: 300, height: 20)
                            .offset(y: -155)

                            Text(hatchPercentText)
                                .font(.custom("Sarabun-Medium", size: 25))
                                .offset(y: -150)

                            Text(hatchRemainingText)
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
                    ForEach(0..<10, id: \.self) { index in
                        if index < inventory.sprites.count {
                            let sprite = inventory.sprites[index]
                            spriteInventoryCard(sprite: sprite)
                        } else {
                            // empty slot
                            inventoryCard {
                                EmptyView()
                            }
                        }
                    }
                }

            case .items: // accessories
                gridPanel {
                    ForEach(0..<10, id: \.self) { index in
                        if index < inventory.accessories.count {
                            let accessory = inventory.accessories[index]
                            accessoryInventoryCard(accessory: accessory)
                        } else {
                            inventoryCard {
                                EmptyView()
                            }
                        }
                    }
                }

            case .eggs:
                gridPanel {
                    ForEach(0..<9, id: \.self) { index in
                        inventoryCard {
                            if index < inventory.eggs.count {
                                let egg = inventory.eggs[index]
                                Image(egg.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(14)
                            } else {

                            }
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
    
    private func spriteInventoryCard(sprite: Sprite) -> some View {
        ZStack {
            // Base card with the sprite image
            inventoryCard {
                Image(sprite.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(14)
            }

            // Equip button overlay at the bottom of the card
            VStack {
                Spacer()
                Button {
                    inventory.equippedSpriteImageName = sprite.imageName
                } label: {
                    Text("equip")
                        .font(.custom("Sarabun-Regular", size: 16))
                        .foregroundColor(.black)
                        .frame(width: 80, height: 28)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "B2E5AB")) // same vibe as your other buttons
                                .shadow(color: .black.opacity(0.25),
                                        radius: 2,
                                        x: 0,
                                        y: 2)
                        )
                }
                .padding(.bottom, 8)
            }
        }
    }
    
    private func accessoryInventoryCard(accessory: Accessory) -> some View {
        ZStack {
            // Base card with accessory image
            inventoryCard {
                Image(accessory.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(14)
            }

            // Equip button overlay at the bottom of the card
            VStack {
                Spacer()
                Button {
                    inventory.equippedAccessoryImageName = accessory.imageName
                } label: {
                    Text("equip")
                        .font(.custom("Sarabun-Regular", size: 16))
                        .foregroundColor(.black)
                        .frame(width: 80, height: 28)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "B2E5AB"))
                                .shadow(color: .black.opacity(0.25),
                                        radius: 2,
                                        x: 0,
                                        y: 2)
                        )
                }
                .padding(.bottom, 8)
            }
        }
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
    InventoryView()
        .environmentObject(TabRouter())
        .environmentObject(InventoryModel())
}
