//
//  SessionManager.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    private static let userDefault = UserDefaults.standard
    
    static var isLoggedIn: Bool {
        set {
            userDefault.set(newValue, forKey: AppConstants.keyIsLoggedIn)
        }
        
        get {
            return userDefault.bool(forKey: AppConstants.keyIsLoggedIn)
        }
    }
    
    static var loginToken: LoginToken? {
        set {
            if let newValue = newValue, let encodedData = try? JSONEncoder().encode(newValue) {
                userDefault.set(encodedData, forKey: AppConstants.keyLoginToken)
            }
        }
        
        get {
            var loginToken: LoginToken? = nil
            if let data = userDefault.object(forKey: AppConstants.keyLoginToken) as? Data {
                if let decodedData = try? JSONDecoder().decode(LoginToken.self, from: data) {
                    loginToken = decodedData
                }
            }
            return loginToken
        }
    }
    
    static var userAccount: UserAccount? {
        set {
            if let newValue = newValue, let encodedData = try? JSONEncoder().encode(newValue) {
                userDefault.set(encodedData, forKey: AppConstants.keyUserAccount)
            }
        }
        
        get {
            var userAccount: UserAccount? = nil
            if let data = userDefault.object(forKey: AppConstants.keyUserAccount) as? Data {
                if let decodedData = try? JSONDecoder().decode(UserAccount.self, from: data) {
                    userAccount = decodedData
                }
            }
            return userAccount
        }
    }
    
    static var registeredUsers: RegisteredUsers? {
        set {
            if let newValue = newValue, let encodedData = try? JSONEncoder().encode(newValue) {
                userDefault.set(encodedData, forKey: AppConstants.keyRegisteredUsers)
            }
        }
        
        get {
            var registeredUsers: RegisteredUsers? = nil
            if let data = userDefault.object(forKey: AppConstants.keyRegisteredUsers) as? Data {
                if let decodedData = try? JSONDecoder().decode(RegisteredUsers.self, from: data) {
                    registeredUsers = decodedData
                }
            }
            return registeredUsers
        }
    }
    
    static func logout() {
        isLoggedIn = false
    }
}
