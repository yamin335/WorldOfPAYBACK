//
//  TransactionTransformer.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

struct TransactionTransformer: DTOToEntityTransformerType {
    private let aliasTransformer: TransactionAliasTransformer
    private let detailTransformer: TransactionDetailTransformer
    
    func transform(dto: TransactionDTO) -> TransactionEntity {
        .init(
            partnerDisplayName: dto.partnerDisplayName,
            alias: aliasTransformer.transform(dto: dto.alias),
            category: dto.category,
            transactionDetail: detailTransformer.transform(dto: dto.transactionDetail)
        )
    }
}

struct TransactionAliasTransformer: DTOToEntityTransformerType {
    func transform(dto: TransactionAliasDTO) -> TransactionAliasEntity {
        .init(reference: dto.reference ?? "")
    }
}

struct TransactionDetailTransformer: DTOToEntityTransformerType {
    private let valueTransformer: TransactionValueTransformer
    
    func transform(dto: TransactionDetailDTO) -> TransactionDetailEntity {
        .init(
            description: dto.description ?? "",
            bookingDate: dto.bookingDate,
            value: valueTransformer.transform(dto: dto.value)
        )
    }
}

struct TransactionValueTransformer: DTOToEntityTransformerType {
    func transform(dto: TransactionValueDTO) -> TransactionValueEntity {
        .init(amount: dto.amount, currency: dto.currency)
    }
}
