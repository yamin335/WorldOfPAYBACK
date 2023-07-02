//
//  ApiService.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import Combine

class ApiService {
    enum APIFailureCondition: Error {
        case InvalidServerResponse
    }
    
    static func loadTransactions(email: String, partnerId: String?) -> AnyPublisher<TransactionsResponse, NetworkError>? {
        // Default request type is .get request
        let request = NetworkRequest<TransactionsResponse>()
        request.httpBodyParam = ["email": email]
        request.queryParam = ["partnerId": partnerId]
        request.headers = RequestHelper.getAuthHeaders()
        request.url = RequestHelper.allTransactions
        
        return NetworkService().perform(request)
    }
}
