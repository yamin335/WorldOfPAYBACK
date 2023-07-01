//
//  AppState.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    enum AppDeployment: String {
        case production = "Production"
        case qa         = "QA"
    }
    
    #if DEVELOPMENT
    @Published var deploymentBuild: AppDeployment = .qa
    #else
    @Published var deploymentBuild: AppDeployment = .production
    #endif
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: AppConstants.keyIsLoggedIn)
        }
    }
    
    @Published var isSplashShown: Bool
    
    @Published var isLoading: Bool
    
    @Published var isConnected: Bool
    
    @Published var accessToken: String? {
        didSet {
            if accessToken == nil {
                UserDefaults.standard.removeObject(forKey: "access_token")
            } else {
                UserDefaults.standard.set(accessToken, forKey: "access_token")
            }
        }
    }
    
    @Published var isShowingErrorMsg: Bool = false
    @Published var isShowingSuccessMsg: Bool = false
    @Published var errorMessage: String = ""
    @Published var successMessage = ""
    
        
    init() {
        self.isSplashShown = false
        self.isLoading = false
        self.accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        self.isShowingErrorMsg = false
        self.isShowingSuccessMsg = false
        self.errorMessage = ""
        self.successMessage = ""
        self.isLoggedIn = UserDefaults.standard.bool(forKey: AppConstants.keyIsLoggedIn)
        self.isConnected = false
    }
}
