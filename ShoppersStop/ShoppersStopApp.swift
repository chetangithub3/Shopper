//
//  ShoppersStopApp.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI
import SwiftData

@main
struct ShoppersStopApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            MainView()
        }.modelContainer(for: Product.self)
            .environment(networkMonitor)
    }
}



