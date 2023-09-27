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
