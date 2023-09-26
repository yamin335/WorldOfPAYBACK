//
//  TransactionDTO.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 24.09.23.
//

import Foundation

struct TransactionListDTO: Codable {
    let items: [TransactionDTO]
    let code: Int
}

struct TransactionDTO: Codable {
    let partnerDisplayName: String
    let alias: TransactionAliasDTO
    let category: Int
    let transactionDetail: TransactionDetailDTO
}

struct TransactionAliasDTO: Codable {
    let reference: String?
}

struct TransactionDetailDTO: Codable {
    let description: String?
    let bookingDate: Date
    let value: TransactionValueDTO
}

struct TransactionValueDTO: Codable {
    let amount: Int
    let currency: String
}
