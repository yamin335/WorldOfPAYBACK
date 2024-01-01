//
//  NetworkConnectivityUseCase.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 05.10.23.
//

import Network
import Foundation

protocol NetworkConnectivityUseCaseType {
    var isConnected: AsyncStream<Bool> { get }
}

final class NetworkConnectivityUseCase: NetworkConnectivityUseCaseType {
    private let networkMonitor = NWPathMonitor()
    private let networkMonitorQueue = DispatchQueue(label: "com.payback.networkMonitorQueue")
    private var continuation: AsyncStream<Bool>.Continuation? {
        willSet {
            continuation?.finish()
        }
    }
    
    var isConnected: AsyncStream<Bool> {
        AsyncStream(bufferingPolicy: .bufferingNewest(1)) { [weak self] (cont: AsyncStream<Bool>.Continuation) -> Void in
            guard let self else { return }
            continuation = cont
            continuation?.yield(networkMonitor.currentPath.status == .satisfied)
        }
    }
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.continuation?.yield(path.status == .satisfied)
        }
        
        networkMonitor.start(queue: networkMonitorQueue)
    }
    
    deinit {
        networkMonitor.cancel()
        continuation?.finish()
    }
}
