//
//  NetworkMonitor.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import Foundation
import Network

@Observable
final class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = true

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        Task {
            await MainActor.run {
                self.objectWillChange.send()
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
