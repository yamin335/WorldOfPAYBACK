//
//  NetworkUtils.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

class RequestHelper {
    #if DEVELOPMENT
    static let baseUrl = "https://api-test.payback.com"
    #else
    static let baseUrl = "https://api.payback.com"
    #endif
    private static let apiVersion = "v1"
    private static let authRepo = "auth"
    private static let transactionRepo = "transactions"
    
    static let login = "\(baseUrl)/\(apiVersion)/\(authRepo)"
    static let signUp = "\(baseUrl)/\(apiVersion)/\(authRepo)"
    static let allProducts = "\(baseUrl)/\(apiVersion)/\(transactionRepo)"
    
    static func getCommonUrlRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        //Setting common headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func getAuthUrlRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        //Setting common headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let loggedUser = UserLocalStorage.getUserCredentials().loggedUser
        request.setValue(loggedUser?.ispToken ?? "", forHTTPHeaderField: "AuthorizedToken")
        let userId = loggedUser?.userID ?? 0
        request.setValue(String(userId), forHTTPHeaderField: "userId")
        request.setValue("3", forHTTPHeaderField: "platformId")
        
        return request
    }
}
