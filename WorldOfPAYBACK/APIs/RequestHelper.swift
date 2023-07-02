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
    
    static let successCode = 200
    static let errorCode = 401
    
    static func getAuthHeaders() -> Dictionary<String, String> {
        return ["AuthorizedToken" : SessionManager.shared.loginToken?.accessToken ?? ""]
    }
}
