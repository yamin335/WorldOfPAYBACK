//
//  TransactionListItem.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct TransactionListItem: View {
    let data: Transaction
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 4) {
                Text("\(data.partnerDisplayName ?? "Partner: N/A")")
                    .textStyle(TitleStyle())
                Text("\(data.transactionDetail?.bookingDate.toFormattedDateString() ?? "no date found")")
                    .textStyle(DateStyle())
            }
            HStack(alignment: .top, spacing: 30) {
                Text("\(data.transactionDetail?.description ?? "Description: N/A")")
                    .textStyle(FootNoteStyle())
                Text("\(data.parseAmount())")
                    .textStyle(AmountStyle())
            }.padding(.top, 5)
        }
        .padding(.vertical, 12)
    }
}
