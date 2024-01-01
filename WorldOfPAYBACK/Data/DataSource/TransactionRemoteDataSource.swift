//
//  TransactionRemoteDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

protocol TransactionRemoteDataSourceType {
    func getTransaction(shouldForceErrorState: Bool) async throws -> TransactionListDTO
}

struct TransactionRemoteDataSource: TransactionRemoteDataSourceType {
    private let httpClient: HttpClientType
    private let apiFactory: TransactionApiFactoryType
    
    func getTransaction(shouldForceErrorState: Bool) async throws -> TransactionListDTO {
        let request = shouldForceErrorState ? apiFactory.createErrorResponse() : apiFactory.createSuccessResponse()
        return try await httpClient.fetch(resource: request)
    }
}
