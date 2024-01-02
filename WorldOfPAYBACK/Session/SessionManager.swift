//
//  SessionManager.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

protocol SessionManagerType {
    var isLoggedIn: Bool { get set }
    var sumOfAllTransaction: Int { get set }
    var loggedUser: UserAccount? { get set }
    var registeredUsers: RegisteredUsers? { get set }
    func logout()
}

class SessionManager: SessionManagerType {
    private let userDefault = UserDefaults.standard
    
    var isLoggedIn: Bool {
        set {
            userDefault.set(newValue, forKey: AppConstants.keyIsLoggedIn)
        }
        
        get {
            return userDefault.bool(forKey: AppConstants.keyIsLoggedIn)
        }
    }
    
    var sumOfAllTransaction: Int {
        set {
            userDefault.set(newValue, forKey: AppConstants.keySumOfAllTransaction)
        }
        
        get {
            return userDefault.integer(forKey: AppConstants.keySumOfAllTransaction)
        }
    }
    
    var loggedUser: UserAccount? {
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
    
    var registeredUsers: RegisteredUsers? {
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
    
    func logout() {
        isLoggedIn = false
    }
}
