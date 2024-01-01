//
//  TransactionApiFactory.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 03.10.23.
//

import Foundation

protocol TransactionApiFactoryType {
    func createSuccessResponse() -> URLResource<TransactionListDTO>
    func createErrorResponse() -> URLResource<TransactionListDTO>
}

struct TransactionApiFactory: TransactionApiFactoryType {
    func createSuccessResponse() -> URLResource<TransactionListDTO> {
        create(isErrorState: false)
    }
    
    func createErrorResponse() -> URLResource<TransactionListDTO> {
        create(isErrorState: true)
    }
    
    private func create(isErrorState: Bool) -> URLResource<TransactionListDTO> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let mockResult: MockURLResource.MockURLResourceResult =
        isErrorState ? .failure(.invalidHttpUrlResponse) :.success(.file(jsonName: "PBTransactions"))
        
        return .get(
            path: "/transactions",
            mock: .init(
                result: mockResult
            ),
            decoder: decoder
        )
    }
}
