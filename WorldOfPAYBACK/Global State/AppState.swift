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

class AppState: AppStateType {
    private let keyLoggedStatus = "key_login"
    
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
