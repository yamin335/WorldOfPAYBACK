//
//  TransactionUseCase.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

protocol TransactionUseCaseType {
    func getTransaction(shouldForceErrorState: Bool) async throws -> [TransactionEntity]
}

struct TransactionUseCase: TransactionUseCaseType {
    private let transactionRepository: TransactionRepositoryType
    private let transactionTransformer: TransactionTransformer
    
    func getTransaction(shouldForceErrorState: Bool) async throws -> [TransactionEntity] {
        try await transactionRepository.getTransaction(
            shouldForceErrorState: shouldForceErrorState
        ).map(transactionTransformer.transform(dto:))
    }
}
