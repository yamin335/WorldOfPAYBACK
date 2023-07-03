//
//  AppConstants.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import SwiftUI

struct AppConstants {
    private init () {}
    // MARK: - Local Storage Keys
    static let keyIsLoggedIn = "is_logged_in"
    static let keyLoginToken = "login_token"
    static let keyUserAccount = "user_account"
    static let keyRegisteredUsers = "registered_users"
    
    // MARK: - Global constant values
    static let toastTime = 0.5
    static let toastStayTime = 2.0
    static let mockWaitingTime = 2.0
    
    //  MARK: - Default login credentials
    static let defaultEmail = "default@payback.de"
    static let defaultPassword = "12345"
    
    static let defaultCurrency = "usd"
    
    static let networkErrorMsg = "Please connect to a network and try again!"
    static let connectedMsg = "Connected to network!"
    static let disConnectedMsg = "Disconnected from network!"
    
    static let emailValidator = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
    
    static var appLaunched = false
}
