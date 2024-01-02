//
//  AppState.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI
import Combine

protocol AppStateType: ObservableObject {
    var isLoggedIn: Bool { get set }
    var isSplashShown: Bool { get set }
}
  
class AppState: ObservableObject {
    private let keyLoggedStatus = "key_login"
    enum AppDeployment: String {
        case production = "Production"
        case qa         = "QA"
    }
    
    #if DEBUG
    @Published var deploymentBuild: AppDeployment = .qa
    #else
    @Published var deploymentBuild: AppDeployment = .production
    #endif
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: keyLoggedStatus)
        }
    }
    
    @Published var isSplashShown: Bool
        
    init() {
        self.isSplashShown = false
        self.isLoggedIn = UserDefaults.standard.bool(forKey: AppConstants.keyIsLoggedIn)
    }
}
