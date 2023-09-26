//
//  TransactionEntity.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

struct TransactionEntity: Equatable, Hashable {
    let partnerDisplayName: String
    let alias: TransactionAliasEntity
    let category: Int
    let transactionDetail: TransactionDetailEntity
}

struct TransactionAliasEntity: Equatable, Hashable {
    let reference: String
}

struct TransactionDetailEntity: Equatable, Hashable {
    let description: String
    let bookingDate: Date
    let value: TransactionValueEntity
}

struct TransactionValueEntity: Equatable, Hashable {
    let amount: Int
    let currency: String
}
