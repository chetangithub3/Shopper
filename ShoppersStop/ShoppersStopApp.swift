//
//  ShoppersStopApp.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI
import SwiftData
import Foundation
import SystemConfiguration
@main
struct ShoppersStopApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }.modelContainer(for: Product.self)
    }
}
import SwiftUI


class NetworkMonitor: ObservableObject {
    private var reachability: SCNetworkReachability?
    
    @Published var isConnected: Bool = true
    
    init() {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") else { return }
        self.reachability = reachability
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        isConnected = flags.contains(.reachable)
        
    }
    
    func startMonitoring() {
        guard let reachability = reachability else {return}
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<NetworkMonitor>.passUnretained(self).toOpaque())
        SCNetworkReachabilitySetCallback(reachability, { (reachability, flags, info) in
            guard let info = info else { return }
            let networkMonitor = Unmanaged<NetworkMonitor>.fromOpaque(info).takeUnretainedValue()
            networkMonitor.isConnected = flags.contains(.reachable)
        }, &context)
        SCNetworkReachabilitySetDispatchQueue(reachability, DispatchQueue.main)
    }
    
    func stopMonitoring() {
        guard let reachability = reachability else {return}
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
    }
}

struct MainView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
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
                if networkMonitor.isConnected{
                    OnboardingView()
                } else {
                    NetworkErrorView()
                }
            }
        }
        .overlay(content: {
            if !networkMonitor.isConnected {
                NetworkErrorView()
            }
        })
        .onAppear {
            networkMonitor.startMonitoring()
        }
        .onDisappear {
            networkMonitor.stopMonitoring()
        }
    }
}
