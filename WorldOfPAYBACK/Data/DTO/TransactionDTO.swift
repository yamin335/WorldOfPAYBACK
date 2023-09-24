//
//  TransactionDTO.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 24.09.23.
//

import Foundation

// MARK: - TransactionListDTO
struct TransactionListDTO: Codable {
    let items: [TransactionDTO]?
    let code: Int?
}

// MARK: - TransactionDTO
struct TransactionDTO: Codable {
    let partnerDisplayName: String?
    let alias: AliasDTO?
    let category: Int?
    let transactionDetail: TransactionDetailDTO?
}

// MARK: - AliasDTO
struct AliasDTO: Codable {
    let reference: String?
}

// MARK: - TransactionDetailDTO
struct TransactionDetailDTO: Codable {
    let description: String?
    let bookingDate: Date?
    let value: TransactionValueDTO?
}

// MARK: - TransactionValueDTO
struct TransactionValueDTO: Codable {
    let amount: Int?
    let currency: String?
}
