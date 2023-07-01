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
struct Transaction: Codable {
    let partnerDisplayName: String?
    let alias: Alias?
    let category: Int?
    let transactionDetail: TransactionDetail?
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String?
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    let description: String?
    let bookingDate: Date?
    let value: TransactionValue?
}

// MARK: - TransactionValue
struct TransactionValue: Codable {
    let amount: Int?
    let currency: String?
}
