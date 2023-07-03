//
//  TransactionsResponse.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

// MARK: - TransactionsResponse
struct TransactionsResponse: Codable {
    let items: [Transaction]?
    let code: Int?
}

// MARK: - Transaction
struct Transaction: Codable, Hashable {
    let partnerDisplayName: String?
    let alias: Alias?
    let category: Int?
    let transactionDetail: TransactionDetail?
}

// MARK: - Alias
struct Alias: Codable, Hashable {
    let reference: String?
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable, Hashable {
    let description: String?
    let bookingDate: Date?
    let value: TransactionValue?
}

// MARK: - TransactionValue
struct TransactionValue: Codable, Hashable {
    let amount: Int?
    let currency: String?
}
