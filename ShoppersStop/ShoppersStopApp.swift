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
    var body: some Scene {
        WindowGroup {
            MainView()
        }.modelContainer(for: Product.self)
    }
}


struct MainView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    
    var body: some View {
        if isOnboardingDone {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}
