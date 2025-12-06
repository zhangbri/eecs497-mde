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
    .init(name: "Bowtie",        rarity: "Common", colorHex: "884723", imageName: "bowtie"),
    .init(name: "Bow",            rarity: "Common", colorHex: "884723", imageName: "bow"),
    .init(name: "Angry Vein",  rarity: "Uncommon",   colorHex: "39B500", imageName: "angry vien"),
    .init(name: "Chef Hat", rarity: "Uncommon",   colorHex: "39B500", imageName: "chef hat"),
    .init(name: "Top Hat",        rarity: "Rare",   colorHex: "005FCC", imageName: "top hat"),
    .init(name: "Tie",            rarity: "Rare",   colorHex: "005FCC", imageName: "tie"),
    .init(name: "Heart Glasses",  rarity: "Epic",   colorHex: "AA00A8", imageName: "heart glasses"),
    .init(name: "Crown",          rarity: "Epic",   colorHex: "AA00A8", imageName: "crown"),
    .init(name: "Chain",          rarity: "Legendary",   colorHex: "D4A017", imageName: "chain"),
    .init(name: "Sunglasses",  rarity: "Legendary",   colorHex: "D4A017", imageName: "sunglasses"),
]

struct Egg: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rarity: String
    let colorHex: String
    let imageName: String
}

let allEggs: [Egg] = [
    .init(name: "White",  rarity: "Common", colorHex: "884723", imageName: "white-egg"),
    .init(name: "Green",  rarity: "Common", colorHex: "884723", imageName: "green-egg"),
    .init(name: "Purple", rarity: "Uncommon",   colorHex: "39B500", imageName: "purple-egg"),
    .init(name: "Pink",   rarity: "Uncommon",   colorHex: "39B500", imageName: "pink-egg"),
    .init(name: "Blue",   rarity: "Rare",   colorHex: "005FCC", imageName: "blue-egg"),
    .init(name: "Red",    rarity: "Rare",   colorHex: "005FCC", imageName: "red-egg"),
    .init(name: "Stripe",   rarity: "Epic",   colorHex: "AA00A8", imageName: "Stripe"),
    .init(name: "Lavender",    rarity: "Epic",   colorHex: "AA00A8", imageName: "Lavender"),
    .init(name: "Terracotta",    rarity: "Legendary",   colorHex: "D4A017", imageName: "Terracotta")
    
]

struct Sprite: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rarity: String
    let colorHex: String
    let imageName: String
}

let allSprites: [Sprite] = [
    .init(name: "Grey Tabby",      rarity: "Common", colorHex: "884723", imageName: "grey-tabby-cat"),
    .init(name: "White",       rarity: "Common", colorHex: "884723", imageName: "white-cat"),
    .init(name: "Orange Tabby",rarity: "Uncommon",   colorHex: "39B500", imageName: "orange-tabby-cat"),
    .init(name: "Grey White",  rarity: "Uncommon",   colorHex: "39B500", imageName: "grey-white-cat"),
    .init(name: "Tuxedo",      rarity: "Rare",   colorHex: "005FCC", imageName: "tuxedo-cat"),
    .init(name: "Black",       rarity: "Rare",   colorHex: "005FCC", imageName: "black-cat"),
    .init(name: "Prussian",      rarity: "Epic",   colorHex: "AA00A8", imageName: "prussian cat"),
    .init(name: "Pink",       rarity: "Epic",   colorHex: "AA00A8", imageName: "pink cat"),
    .init(name: "Calico",      rarity: "Legendary",   colorHex: "D4A017", imageName: "calico cat"),
    .init(name: "Siamese",       rarity: "Legendary",   colorHex: "D4A017", imageName: "siamese cat")
]

let rarityWeights: [String: Double] = [
    "Common": 60,
    "Uncommon": 23,
    "Rare": 10,
    "Epic": 5,
    "Legendary": 2
]

func weightedRandom<T>(_ items: [(value: T, weight: Double)]) -> T? {
    let totalWeight = items.reduce(0) { $0 + $1.weight }
    guard totalWeight > 0 else { return nil }
    
    let random = Double.random(in: 0..<totalWeight)
    var running: Double = 0
    
    for (value, weight) in items {
        running += weight
        if random < running {
            return value
        }
    }
    
    return items.last?.value
}

struct GachaView: View {
    @EnvironmentObject private var router: TabRouter
    @EnvironmentObject private var inventory: InventoryModel
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
    
    @State private var rolledAccessoryBatch: [Accessory] = []
    @State private var rolledEggBatch: [Egg] = []
    @State private var rolledSpriteBatch: [Sprite] = []

    @State private var showAccessoryBatchResult = false
    @State private var showEggBatchResult = false
    @State private var showSpriteBatchResult = false

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
                                                                rollAccessoryOnce()
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
                                                            Button(action: {
                                                                rollAccessoryBatch()
                                                            }) {
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
                                                                rollEggOnce()
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
                                                            Button(action: {
                                                                rollEggBatch()
                                                            }) {
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
                                                                rollSpriteOnce()
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
                                                            Button(action: {
                                                                rollSpriteBatch()
                                                            }) {
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

                .fullScreenCover(isPresented: $showAccessoryResult) {
                    if let rolledAccessory {
                        AccessoryResultView(accessory: rolledAccessory) {
                            rollAccessoryOnce()
                        }
                    }
                }

                .fullScreenCover(isPresented: $showEggResult) {
                    if let rolledEgg {
                        EggResultView(egg: rolledEgg) {
                            rollEggOnce()
                        }
                    }
                }

                .fullScreenCover(isPresented: $showSpriteResult) {
                    if let rolledSprite {
                        SpriteResultView(sprite: rolledSprite) {
                            rollSpriteOnce()
                        }
                    }
                }
                .fullScreenCover(isPresented: $showAccessoryBatchResult) {
                    if !rolledAccessoryBatch.isEmpty {
                        AccessoryBatchResultView(accessories: rolledAccessoryBatch) {
                            rollAccessoryBatch()
                        }
                    }
                }
                .fullScreenCover(isPresented: $showEggBatchResult) {
                    if !rolledEggBatch.isEmpty {
                        EggBatchResultView(eggs: rolledEggBatch) {
                            rollEggBatch()
                        }
                    }
                }
                .fullScreenCover(isPresented: $showSpriteBatchResult) {
                    if !rolledSpriteBatch.isEmpty {
                        SpriteBatchResultView(sprites: rolledSpriteBatch) {
                            rollSpriteBatch()
                        }
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

    private func rollAccessoryOnce() {
        if spendCoins(50), let accessory = rollAccessoryWithRarity() {
            inventory.add(accessory: accessory)
            rolledAccessory = accessory
            showAccessoryResult = true
        }
    }

    private func rollAccessoryBatch() {
        if spendCoins(500) {
            var pulled: [Accessory] = []
            for _ in 0..<5 {
                if let accessory = rollAccessoryWithRarity(){
                    inventory.add(accessory: accessory)
                    pulled.append(accessory)
                }
            }
            rolledAccessoryBatch = pulled
            showAccessoryBatchResult = true
        }
    }

    private func rollEggOnce() {
        if spendCoins(30), let egg = rollEggWithRarity() {
            inventory.add(egg: egg)
            rolledEgg = egg
            showEggResult = true
        }
    }

    private func rollEggBatch() {
        if spendCoins(300) {
            var pulled: [Egg] = []
            for _ in 0..<5 {
                if let egg = rollEggWithRarity() {
                    inventory.add(egg: egg)
                    pulled.append(egg)
                }
            }
            rolledEggBatch = pulled
            showEggBatchResult = true
        }
    }

    private func rollSpriteOnce() {
        if spendCoins(60), let sprite = rollSpriteWithRarity() {
            inventory.add(sprite: sprite)
            rolledSprite = sprite
            showSpriteResult = true
        }
    }

    private func rollSpriteBatch() {
        if spendCoins(600) {
            var pulled: [Sprite] = []
            for _ in 0..<5 {
                if let sprite = rollSpriteWithRarity() {
                    inventory.add(sprite: sprite)
                    pulled.append(sprite)
                }
            }
            rolledSpriteBatch = pulled
            showSpriteBatchResult = true
        }
    }
    
    // MARK: - Rarity-based roll helpers

    private func rollAccessoryWithRarity() -> Accessory? {
        let grouped = Dictionary(grouping: allAccessories, by: { $0.rarity })
        
        let rarityWeightPairs: [(value: String, weight: Double)] = grouped.compactMap { (rarity, items) in
            guard !items.isEmpty, let weight = rarityWeights[rarity] else { return nil }
            return (value: rarity, weight: weight)
        }
        
        guard let chosenRarity = weightedRandom(rarityWeightPairs),
              let pool = grouped[chosenRarity],
              let accessory = pool.randomElement() else {
            return nil
        }
        
        return accessory
    }

    private func rollEggWithRarity() -> Egg? {
        let grouped = Dictionary(grouping: allEggs, by: { $0.rarity })
        
        let rarityWeightPairs: [(value: String, weight: Double)] = grouped.compactMap { (rarity, items) in
            guard !items.isEmpty, let weight = rarityWeights[rarity] else { return nil }
            return (value: rarity, weight: weight)
        }
        
        guard let chosenRarity = weightedRandom(rarityWeightPairs),
              let pool = grouped[chosenRarity],
              let egg = pool.randomElement() else {
            return nil
        }
        
        return egg
    }

    private func rollSpriteWithRarity() -> Sprite? {
        let grouped = Dictionary(grouping: allSprites, by: { $0.rarity })
        
        let rarityWeightPairs: [(value: String, weight: Double)] = grouped.compactMap { (rarity, items) in
            guard !items.isEmpty, let weight = rarityWeights[rarity] else { return nil }
            return (value: rarity, weight: weight)
        }
        
        guard let chosenRarity = weightedRandom(rarityWeightPairs),
              let pool = grouped[chosenRarity],
              let sprite = pool.randomElement() else {
            return nil
        }
        
        return sprite
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
        VStack {
            ZStack {
                Text("Accessories")
                    .font(.custom("Moulpali-Regular", size: 40))
                    .foregroundColor(.black)
                    .offset(y:-10)
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .offset(y:-15)
                            .offset(x:-12.5)
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(Array(accessories.enumerated()), id: \.element.id) { index, accessory in
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "F2EDE7"))
                                .frame(width: 110, height: 110)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                .overlay(
                                    Image(accessory.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )
                            
                            Text(accessory.name)
                                .font(.custom("Moulpali-Regular", size: 26))
                                .foregroundColor(.black)
                                .offset(y:-30)
                            
                            Text(accessory.rarity)
                                .font(.custom("VictorMono-Regular", size: 16))
                                .foregroundColor(Color(hex: accessory.colorHex))
                                .offset(y:-45)
                        }
                        .offset(x: index % 2 == 0 ? 10 : -10)
                        .padding(.top, {
                            switch index {
                            case 0, 1:
                                0
                            case 2, 3:
                                -30
                            case 4, 5:
                                -30
                            case 6, 7:
                                -30
                            default:
                                -30
                            }
                        }())
                    }
                }
            }
            .padding(.top, -70)
        }
        .frame(width: 340, height: 660)
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
        VStack {
            ZStack {
                Text("Sprites")
                    .font(.custom("Moulpali-Regular", size: 40))
                    .foregroundColor(.black)
                    .offset(y:-10)
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .offset(y:-15)
                            .offset(x:-12.5)
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(Array(sprites.enumerated()), id: \.element.id) { index, sprite in
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "F2EDE7"))
                                .frame(width: 110, height: 110)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                .overlay(
                                    Image(sprite.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )
                            
                            Text(sprite.name)
                                .font(.custom("Moulpali-Regular", size: 26))
                                .foregroundColor(.black)
                                .offset(y:-30)
                            
                            Text(sprite.rarity)
                                .font(.custom("VictorMono-Regular", size: 16))
                                .foregroundColor(Color(hex: sprite.colorHex))
                                .offset(y:-45)
                        }
                        .offset(x: index % 2 == 0 ? 10 : -10)
                        .padding(.top, {
                            switch index {
                            case 0, 1:
                                0
                            case 2, 3:
                                -30
                            case 4, 5:
                                -30
                            case 6, 7:
                                -30
                            default:
                                -30
                            }
                        }())
                    }
                }
            }
            .padding(.top, -70)
        }
        .frame(width: 340, height: 660)
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
        VStack {
            ZStack {
                Text("Eggs")
                    .font(.custom("Moulpali-Regular", size: 40))
                    .foregroundColor(.black)
                    .offset(y:-10)
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .offset(y:-15)
                            .offset(x:-12.5)
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(Array(eggs.enumerated()), id: \.element.id) { index, egg in
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "F2EDE7"))
                                .frame(width: 110, height: 110)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                .overlay(
                                    Image(egg.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                )
                            
                            Text(egg.name)
                                .font(.custom("Moulpali-Regular", size: 26))
                                .foregroundColor(.black)
                                .offset(y:-30)
                            
                            Text(egg.rarity)
                                .font(.custom("VictorMono-Regular", size: 16))
                                .foregroundColor(Color(hex: egg.colorHex))
                                .offset(y:-45)
                        }
                        .offset(x: index % 2 == 0 ? 10 : -10)
                        .padding(.top, {
                            switch index {
                            case 0, 1:
                                0
                            case 2, 3:
                                -30
                            case 4, 5:
                                -30
                            case 6, 7:
                                -30
                            default:
                                -30
                            }
                        }())
                    }
                }
            }
            .padding(.top, -70)
        }
        .frame(width: 340, height: 660)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "EBE3D7"))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        )
    }
}

struct AccessoryResultView: View {
    @Environment(\.dismiss) private var dismiss
    let accessory: Accessory
    let onRollAgain: () -> Void
    
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
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
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
    let onRollAgain: () -> Void
    
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
                    .frame(width: 250, height: 250)
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
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
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
    let onRollAgain: () -> Void
    
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
                    .frame(width: 250, height: 250)
                    .offset(y: -20)
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -30)
                    
                    Text(sprite.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: sprite.colorHex))
                        .shadow(color: Color(hex: sprite.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: -25)
                    
                    Text(sprite.name)
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: -35)
                }
                
                VStack {
                    Button {
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                }
                .offset(y: -35)
                
                Spacer()
            }
        }
    }
}
struct AccessoryBatchResultView: View {
    @Environment(\.dismiss) private var dismiss
    let accessories: [Accessory]
    @State private var currentIndex: Int = 0
    let onRollAgain: () -> Void
    
    var body: some View {
        let accessory = accessories[currentIndex]
        
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
                
                HStack {
                    if currentIndex > 0 {
                        Button {
                            if currentIndex > 0 { currentIndex -= 1 }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: -16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                    
                    Image(accessory.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .offset(y: 12)
                    
                    if currentIndex < accessories.count - 1 {
                        Button {
                            if currentIndex < accessories.count - 1 { currentIndex += 1 }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: 16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                }

                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: 2)
                    
                    Text(accessory.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: accessory.colorHex))
                        .shadow(color: Color(hex: accessory.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: 8)
                    
                    Text(accessory.name)
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: -3)
                }
                Text("\(currentIndex + 1)/\(accessories.count)")
                    .font(.custom("Sarabun-Regular", size: 50))
                    .offset(y: -475)
                
                VStack {
                    Button {
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                }
                .offset(y: -68)
                
                Spacer()
            }
        }
    }
}

struct EggBatchResultView: View {
    @Environment(\.dismiss) private var dismiss
    let eggs: [Egg]
    @State private var currentIndex: Int = 0
    let onRollAgain: () -> Void
    
    var body: some View {
        let egg = eggs[currentIndex]
        
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
                
                HStack {
                    if currentIndex > 0 {
                        Button {
                            if currentIndex > 0 { currentIndex -= 1 }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: -16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                    
                    Image(egg.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .offset(y: 12)
                    
                    if currentIndex < eggs.count - 1 {
                        Button {
                            if currentIndex < eggs.count - 1 { currentIndex += 1 }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: 16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                }
                
                VStack {
                    Text("you hatched")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: 2)
                    
                    Text(egg.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: egg.colorHex))
                        .shadow(color: Color(hex: egg.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: 8)
                    
                    Text("\(egg.name) Egg")
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: 3)
                    
                    Text("\(currentIndex + 1)/\(eggs.count)")
                        .font(.custom("Sarabun-Regular", size: 50))
                        .offset(y: -475)
                }
                
                VStack {
                    Button {
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                }
                .offset(y: -68)
                
                Spacer()
            }
        }
    }
}
struct SpriteBatchResultView: View {
    @Environment(\.dismiss) private var dismiss
    let sprites: [Sprite]
    @State private var currentIndex: Int = 0
    let onRollAgain: () -> Void

    var body: some View {
        let sprite = sprites[currentIndex]
        
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
                
                HStack {
                    if currentIndex > 0 {
                        Button {
                            if currentIndex > 0 { currentIndex -= 1 }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: -16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                    
                    Image(sprite.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .offset(y: 12)
                    
                    if currentIndex < sprites.count - 1 {
                        Button {
                            if currentIndex < sprites.count - 1 { currentIndex += 1 }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: 15)
                                .offset(x: 16)
                        }
                    } else {
                        Spacer().frame(width: 40)
                    }
                }
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: 2)
                    
                    Text(sprite.rarity.uppercased())
                        .font(.custom("VictorMono-Regular", size: 32))
                        .foregroundColor(Color(hex: sprite.colorHex))
                        .shadow(color: Color(hex: sprite.colorHex),
                                radius: 4,
                                x: 0,
                                y: 1)
                        .offset(y: 8)
                    
                    Text(sprite.name)
                        .font(.custom("Sarabun-Regular", size: 40))
                        .foregroundColor(.black)
                        .offset(y: -3)
                    
                    Text("\(currentIndex + 1)/\(sprites.count)")
                        .font(.custom("Sarabun-Regular", size: 50))
                        .offset(y: -475)
                }
                
                VStack {
                    Button {
                        dismiss()
                        onRollAgain()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 24))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                }
                .offset(y: -68)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GachaView()
        .environmentObject(TabRouter())
        .environmentObject(InventoryModel())
}

