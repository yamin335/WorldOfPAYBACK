//
//  TransactionRepository.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 03.10.23.
//

import Foundation

protocol TransactionRepositoryType {
    func getTransaction(shouldForceErrorState: Bool) async throws -> [TransactionDTO]
}

struct TransactionRepository: TransactionRepositoryType {
    private let transactionRemoteDataSource: TransactionRemoteDataSourceType
    
    func getTransaction(shouldForceErrorState: Bool) async throws -> [TransactionDTO] {
        try await transactionRemoteDataSource.getTransaction(
            shouldForceErrorState: shouldForceErrorState
        ).items
    }
}
