//
//  GachaView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct Accessory: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rarity: String
    let colorHex: String
    let imageName: String
}

let allAccessories: [Accessory] = [
    .init(name: "Bow Tie",        rarity: "Common", colorHex: "967259", imageName: "bowtie"),
    .init(name: "Bow",            rarity: "Common", colorHex: "967259", imageName: "bow"),
    .init(name: "Top Hat",        rarity: "Rare",   colorHex: "00FF00", imageName: "top-hat"),
    .init(name: "Tie",            rarity: "Rare",   colorHex: "00FF00", imageName: "tie"),
    .init(name: "Heart Glasses",  rarity: "Epic",   colorHex: "A020F0", imageName: "heart-glasses"),
    .init(name: "Crown",          rarity: "Epic",   colorHex: "A020F0", imageName: "crown")
]

struct Egg: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rarity: String
    let colorHex: String
    let imageName: String
}

let allEggs: [Egg] = [
    .init(name: "White",  rarity: "Common", colorHex: "967259", imageName: "white-egg"),
    .init(name: "Green",  rarity: "Common", colorHex: "967259", imageName: "green-egg"),
    .init(name: "Purple", rarity: "Rare",   colorHex: "00FF00", imageName: "purple-egg"),
    .init(name: "Pink",   rarity: "Rare",   colorHex: "00FF00", imageName: "pink-egg"),
    .init(name: "Blue",   rarity: "Epic",   colorHex: "A020F0", imageName: "blue-egg"),
    .init(name: "Red",    rarity: "Epic",   colorHex: "A020F0", imageName: "red-egg")
]

struct Sprite: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rarity: String
    let colorHex: String
    let imageName: String
}

let allSprites: [Sprite] = [
    .init(name: "Grey Tabby",      rarity: "Common", colorHex: "967259", imageName: "grey-tabby-cat"),
    .init(name: "White Cat",       rarity: "Common", colorHex: "967259", imageName: "white-cat"),
    .init(name: "Orange Tabby Cat",rarity: "Rare",   colorHex: "00FF00", imageName: "orange-tabby-cat"),
    .init(name: "Grey White Cat",  rarity: "Rare",   colorHex: "00FF00", imageName: "grey-white-cat"),
    .init(name: "Tuxedo Cat",      rarity: "Epic",   colorHex: "A020F0", imageName: "tuxedo-cat"),
    .init(name: "Black Cat",       rarity: "Epic",   colorHex: "A020F0", imageName: "black-cat")
]

struct GachaView: View {
    @EnvironmentObject private var router: TabRouter
    private let barHeight: CGFloat = 78
    
    @AppStorage("coins") private var coins: Int = 0

    @State private var showResult = false
    @State private var showEggCollection = false
    @State private var showSpriteCollection = false
    @State private var showAccessoryCollection = false
    
    @State private var rolledAccessory: Accessory?
    @State private var showAccessoryResult = false
    @State private var rolledEgg: Egg?
    @State private var showEggResult = false
    @State private var rolledSprite: Sprite?
    @State private var showSpriteResult = false
    
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
                                                 .offset(x: -8)
                                        }
                                    }
                                    .offset(x: -15, y: 0)
                                }
                                .padding(.leading, 15)
                                Text("Shop")
                                    .font(.custom("Moulpali-Regular", size: 48))
                                    .offset(y:-80)
                                Group{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Accessory")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 61, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("accessorymachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {
                                                            showAccessoryCollection = true
                                                        }) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5,y:-3)

                                                        ZStack{
                                                            Button(action: {
                                                                if spendCoins(50) {
                                                                    rolledAccessory = allAccessories.randomElement()
                                                                    showAccessoryResult = rolledAccessory != nil
                                                                }
                                                            }) {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:74)
                                                                Text("50")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:65)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:4, y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(500) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("500")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:0, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Egg")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 58, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("eggmachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {
                                                            showEggCollection = true
                                                        }) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5, y: -3)

                                                        ZStack{
                                                            Button(action: {
                                                                if spendCoins(30) {
                                                                    rolledEgg = allEggs.randomElement()
                                                                    showEggResult = rolledEgg != nil
                                                                }
                                                            }) {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:79)
                                                                Text("30")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(300) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:85)
                                                                Text("300")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:77)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:-6, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Sprite")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 58, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("spritemachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {
                                                            showSpriteCollection = true
                                                        }) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5, y: -3)

                                                        ZStack{
                                                            Button(action: {
                                                                if spendCoins(60) {
                                                                    rolledSprite = allSprites.randomElement()
                                                                    showSpriteResult = rolledSprite != nil
                                                                }
                                                            }) {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("60")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset( y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(600) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-11)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("600")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:0, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                }
                                .padding(.bottom, 10)
                                .offset(y:-180)
                            }
                            .padding(.bottom, -120)
                        }
                    }
                    BottomNavBar(selection: $router.tab) { _ in }
                        .frame(height: barHeight)
                        .background(Color(hex: "EBE3D7"))
                        .ignoresSafeArea(edges: .bottom)
                        .offset(y: 34)
                }
                .fullScreenCover(isPresented: $showResult) {
                    GachaResultView()
                }
                .fullScreenCover(isPresented: $showAccessoryResult) {
                    if let rolledAccessory {
                        AccessoryResultView(accessory: rolledAccessory)
                    }
                }
                .fullScreenCover(isPresented: $showEggResult) {
                    if let rolledEgg {
                        EggResultView(egg: rolledEgg)
                    }
                }
                .fullScreenCover(isPresented: $showSpriteResult) {
                    if let rolledSprite {
                        SpriteResultView(sprite: rolledSprite)
                    }
                }
                .overlay(
                    Group {
                        if showEggCollection {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    showEggCollection = false
                                }
                            EggCollectionView(isPresented: $showEggCollection,
                                              eggs: allEggs)
                                .transition(.scale)
                        }
                        
                        if showSpriteCollection {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    showSpriteCollection = false
                                }
                            
                            SpriteCollectionView(isPresented: $showSpriteCollection,
                                                 sprites: allSprites)
                                .transition(.scale)
                        }
                        
                        if showAccessoryCollection {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    showAccessoryCollection = false
                                }
                            
                            AccessoryCollectionView(isPresented: $showAccessoryCollection,
                                                    accessories: allAccessories)
                                .transition(.scale)
                        }
                    }
                )
            }
        }
    @discardableResult
    private func spendCoins(_ cost: Int) -> Bool {
        guard coins >= cost else {
            return false
        }
        coins -= cost
        return true
    }
}

struct AccessoryCollectionView: View {
    @Binding var isPresented: Bool
    let accessories: [Accessory]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with title and close button
            ZStack {
                Text("Accessories")
                    .font(.custom("Moulpali-Regular", size: 36))
                    .foregroundColor(.black)
                
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 35, height: 35)
                            Circle()
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 35, height: 35)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            .padding(.bottom, 15)
            
            // Accessory grid (matching EggCollectionView style)
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(accessories) { accessory in
                        VStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                                .overlay(
                                    Image(accessory.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )
                            
                            Text(accessory.name)
                                .font(.custom("Sarabun-Regular", size: 20))
                                .foregroundColor(.black)
                            
                            Text(accessory.rarity)
                                .font(.custom("Sarabun-Regular", size: 14))
                                .foregroundColor(Color(hex: accessory.colorHex))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 15)
        }
        .frame(width: 320, height: 640)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "EBE3D7"))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        )
    }
}


struct SpriteCollectionView: View {
    @Binding var isPresented: Bool
    let sprites: [Sprite]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with title and close button
            ZStack {
                Text("Sprites")
                    .font(.custom("Moulpali-Regular", size: 36))
                    .foregroundColor(.black)
                
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 35, height: 35)
                            Circle()
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 35, height: 35)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            .padding(.bottom, 15)
            
            // Sprite grid (matching egg style)
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(sprites) { sprite in
                        VStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                                .overlay(
                                    Image(sprite.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )
                            
                            Text(sprite.name)
                                .font(.custom("Sarabun-Regular", size: 20))
                                .foregroundColor(.black)
                            
                            Text(sprite.rarity)
                                .font(.custom("Sarabun-Regular", size: 14))
                                .foregroundColor(Color(hex: sprite.colorHex))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 15)
        }
        .frame(width: 320, height: 640)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "EBE3D7"))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        )
    }
}



struct EggCollectionView: View {
    @Binding var isPresented: Bool
    let eggs: [Egg]

    var body: some View {
        VStack(spacing: 0) {
            // Header with title and close button
            ZStack {
                Text("Eggs")
                    .font(.custom("Moulpali-Regular", size: 36))
                    .foregroundColor(.black)

                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 35, height: 35)
                            Circle()
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 35, height: 35)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            .padding(.bottom, 15)

            // Egg grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(eggs) { egg in
                        VStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                                .overlay(
                                    Image(egg.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )

                            Text(egg.name)
                                .font(.custom("Sarabun-Regular", size: 20))
                                .foregroundColor(.black)

                            Text(egg.rarity)
                                .font(.custom("Sarabun-Regular", size: 14))
                                .foregroundColor(Color(hex: egg.colorHex))
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 15)
        }
        .frame(width: 320, height: 640)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "EBE3D7"))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        )
    }
}

struct GachaResultView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            
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
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size:25, weight: .bold))
                        }
                        .offset(y: 35)
                        .offset(x: -12.5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                Image("orangetabby")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 318, height: 318)
                    .offset(y: -30)
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -45)
                    
                    Text("RARE")
                        .font(.custom("VictorMono-Regular", size: 40))
                        .foregroundColor(Color(hex: "E62222"))
                        .shadow(color: Color(hex: "E62222"), radius: 4, x: 0, y: 1)
                        .offset(y: -40)
                    
                    Text("Orange Tabby")
                        .font(.custom("Sarabun-Regular", size: 50))
                        .foregroundColor(.black)
                        .offset(y: -55)
                    }
                
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Equip Now")
                            .font(.custom("Moulpali-Regular", size: 30))
                            .foregroundColor(.black)
                            .frame(width: 245, height: 53)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "B2E5AB"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    .offset(y: 10)
                }
                .offset(y: -55)
                
                Spacer()
            }
        }
    }
}

struct AccessoryResultView: View {
    @Environment(\.dismiss) private var dismiss
    let accessory: Accessory
    
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            
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
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .bold))
                        }
                        .offset(y: 35)
                        .offset(x: -12.5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                Image(accessory.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .offset(y: -20)
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -30)
                    
                    Text(accessory.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: accessory.colorHex))
                        .shadow(color: Color(hex: accessory.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: -25)
                    
                    Text(accessory.name)
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: -35)
                }
                
                VStack {
                    Button {
                        // hook up equip logic here later
                        dismiss()
                    } label: {
                        Text("Equip Now")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "B2E5AB"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    .offset(y: 10)
                }
                .offset(y: -35)
                
                Spacer()
            }
        }
    }
}

struct EggResultView: View {
    @Environment(\.dismiss) private var dismiss
    let egg: Egg
    
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            
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
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .bold))
                        }
                        .offset(y: 35)
                        .offset(x: -12.5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                Image(egg.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260, height: 260)
                    .offset(y: -20)
                
                VStack {
                    Text("you hatched")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -30)
                    
                    Text(egg.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: egg.colorHex))
                        .shadow(color: Color(hex: egg.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: -25)
                    
                    Text("\(egg.name) Egg")
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: -35)
                }
                
                VStack {
                    Button {
                        // Equip egg logic later if you have one
                        dismiss()
                    } label: {
                        Text("Equip Now")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "B2E5AB"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    .offset(y: 10)
                }
                .offset(y: -35)
                
                Spacer()
            }
        }
    }
}

struct SpriteResultView: View {
    @Environment(\.dismiss) private var dismiss
    let sprite: Sprite
    
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            
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
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size:25, weight: .bold))
                        }
                        .offset(y: 35)
                        .offset(x: -12.5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                Image(sprite.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 318, height: 318)
                    .offset(y: -30)
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -45)
                    
                    Text(sprite.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 40))
                        .foregroundColor(Color(hex: sprite.colorHex))
                        .shadow(color: Color(hex: sprite.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: -40)
                    
                    Text(sprite.name)
                        .font(.custom("Sarabun-Regular", size: 50))
                        .foregroundColor(.black)
                        .offset(y: -55)
                }
                
                VStack {
                    Button {
                        // hook up sprite equip logic here later
                        dismiss()
                    } label: {
                        Text("Equip Now")
                            .font(.custom("Moulpali-Regular", size: 30))
                            .foregroundColor(.black)
                            .frame(width: 245, height: 53)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "B2E5AB"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    .offset(y: 10)
                }
                .offset(y: -55)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GachaView().environmentObject(TabRouter())
}

