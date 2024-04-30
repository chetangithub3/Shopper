//
//  MainView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    @Environment(NetworkMonitor.self) private var networkMonitor

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        VStack {
            if isOnboardingDone {
                HomeView()
            } else {
                if networkMonitor.isConnected {
                    OnboardingView()
                } else {
                    NetworkErrorView()
                }
            }
        } .overlay {
            if !networkMonitor.isConnected {
                NetworkErrorView()
            }
        }
    }
}

#Preview {
    MainView()
}
