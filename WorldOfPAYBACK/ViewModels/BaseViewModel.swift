//
//  BaseViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 28.06.23.
//

import Foundation
import Combine

class BaseViewModel: NSObject, ObservableObject, URLSessionTaskDelegate {
    var showLoader = PassthroughSubject<Bool, Never>()
    
    var errorToastPublisher = PassthroughSubject<(Bool, String), Never>()
    var warningToastPublisher = PassthroughSubject<(Bool, String), Never>()
    var successToastPublisher = PassthroughSubject<(Bool, String), Never>()
    
    let config = URLSessionConfiguration.default
    
    var session: URLSession {
        get {
            config.timeoutIntervalForResource = 10 // Value in seconds, default is 7 days!
            config.waitsForConnectivity = true
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue());
        }
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // waiting for connectivity, update UI, etc.
        self.errorToastPublisher.send((true, "Please turn on your internet connection!"))
    }
}
