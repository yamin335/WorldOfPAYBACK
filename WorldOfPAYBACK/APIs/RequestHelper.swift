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
    
    static let login = "\(baseUrl)/\(apiVersion)/\(authRepo)/login"
    static let signUp = "\(baseUrl)/\(apiVersion)/\(authRepo)/register"
    static let allTransactions = "\(baseUrl)/\(apiVersion)/\(transactionRepo)"
    
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
        let accessToken = SessionManager.shared.loginToken?.accessToken
        request.setValue(accessToken, forHTTPHeaderField: "AuthorizedToken")
        if let userId = SessionManager.shared.userAccount?.id {
            request.setValue(String(userId), forHTTPHeaderField: "userId")
        }
        
        return request
    }
}
