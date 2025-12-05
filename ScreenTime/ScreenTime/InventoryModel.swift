//
//  InventoryModel.swift
//  ScreenTime
//
//  Created by Brian Zhang on 12/5/25.
//

import SwiftUI
import Combine

final class InventoryModel: ObservableObject {
    @Published var sprites: [Sprite] = []
    @Published var eggs: [Egg] = []
    @Published var accessories: [Accessory] = []
    
    // Returns true if added, false if you already had it
    @discardableResult
    func add(sprite: Sprite) -> Bool {
        guard !sprites.contains(where: { $0.name == sprite.name }) else { return false }
        sprites.append(sprite)
        return true
    }
    
    @discardableResult
    func add(egg: Egg) -> Bool {
        guard !eggs.contains(where: { $0.name == egg.name }) else { return false }
        eggs.append(egg)
        return true
    }
    
    @discardableResult
    func add(accessory: Accessory) -> Bool {
        guard !accessories.contains(where: { $0.name == accessory.name }) else { return false }
        accessories.append(accessory)
        return true
    }
}
