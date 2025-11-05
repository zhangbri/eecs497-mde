//
//  TabRouter.swift
//  ScreenTime
//
//  Created by Brian Zhang on 11/4/25.
//

// TabRouter.swift
import SwiftUI
import Combine 
final class TabRouter: ObservableObject {
    @Published var tab: PawseTab = .home
}
