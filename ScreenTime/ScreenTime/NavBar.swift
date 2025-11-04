//
//  NavBar.swift
//  ScreenTime
//
//  Created by Brian Zhang on 11/3/25.
//

import SwiftUI

enum PawseTab: CaseIterable {
    case home, shop, inventory, leaderboard, profile
    
    var imageName: String {
        switch self {
        case .home:        return "home_button"
        case .shop:        return "shop_button"
        case .inventory:   return "inventory_button"
        case .leaderboard: return "leaderboard_button"
        case .profile:     return "profile_button"
        }
    }
}

struct BottomNavBar: View {
    @Binding var selection: PawseTab
    var onSelect: (PawseTab) -> Void = { _ in }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "EBE3D7"))
                .frame(height: 78)
                .overlay(
                    Rectangle()
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
            
            HStack(spacing: 20){
                ForEach(PawseTab.allCases, id: \.self) { tab in
                    Button {
                        selection = tab
                        onSelect(tab)
                    } label: {
                        Image(tab.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 55)
                            .opacity(selection == tab ? 1.0 : 0.75)
                    }
                }
            }
            
        }
    }
}

#Preview {
    @State var selectedTab: PawseTab = .home
    return BottomNavBar(selection: $selectedTab)
        .previewLayout(.sizeThatFits)
}
