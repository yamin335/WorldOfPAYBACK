//
//  NetworkObserver.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 28.06.23.
//

import Foundation
import Network
import Combine

enum NetworkStatus: String {
    case connected = "connected"
    case disconnected = "disconnected"
}

class NetworkObserver: ObservableObject {
    @Published private(set) var networkStatus: NetworkStatus = .disconnected
    @Published private(set) var isConnectedOnCellular: Bool = true
    let networkStatusPublisher = PassthroughSubject<NetworkStatus, Never>()
    public private(set) var isConnected: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()

    func startObserving() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnectedOnCellular = path.isExpensive
            }

            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.networkStatus = .connected
                }
                self?.isConnected = true
                self?.networkStatusPublisher.send(.connected)
            } else {
                DispatchQueue.main.async {
                    self?.networkStatus = .disconnected
                }
                self?.isConnected = false
                self?.networkStatusPublisher.send(.connected)
            }
        }

        monitor.start(queue: queue)
    }

    func stopObserving() {
        monitor.cancel()
    }
    
    deinit {
        stopObserving()
    }
}
