//
//  BaseViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 28.06.23.
//

import Foundation
import Combine

class BaseViewModel: NSObject, ObservableObject, URLSessionTaskDelegate {
    var isShowLoader = PassthroughSubject<Bool, Never>()
    
    var errorMsgPublisher = PassthroughSubject<(Bool, String), Never>()
    var successMsgPublisher = PassthroughSubject<(Bool, String), Never>()
    
    let config = URLSessionConfiguration.default
    let session = SessionManager.shared
    
    var urlSession: URLSession {
        get {
            config.timeoutIntervalForResource = 10 // Value in seconds, default is 7 days!
            config.waitsForConnectivity = true
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue());
        }
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // waiting for connectivity, update UI, etc.
        self.showErrorMsg(msg: "Please turn on your internet connection!")
    }
    
    func showLoader() {
        isShowLoader.send(true)
    }
    
    func hideLoader() {
        isShowLoader.send(false)
    }
    
    func showErrorMsg(msg: String) {
        errorMsgPublisher.send((true, msg))
    }
    
    func showSuccessMsg(msg: String) {
        successMsgPublisher.send((true, msg))
    }
}
