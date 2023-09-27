//
//  TransactionRemoteDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

protocol TransactionRemoteDataSourceType {
    func getTransaction(randomGenerator: BooleanRandomGeneratorType) async throws -> [TransactionDTO]
}
