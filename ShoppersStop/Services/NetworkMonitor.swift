//
//  NetworkMonitor.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import Foundation
import SystemConfiguration

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
