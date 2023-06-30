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
        HStack(spacing: 0) {
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
            Image(systemName: "chevron.right")
                .foregroundColor(Color("shadowColor"))
                .padding(.leading, 10)
        }
        .padding(.leading, 16)
        .padding(.trailing, 12)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("gray6")))
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

//struct TransactionListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListItem()
//    }
//}
