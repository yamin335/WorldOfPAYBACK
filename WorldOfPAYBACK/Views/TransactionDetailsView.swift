//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct TransactionDetailsView: View {
    let data: Transaction
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("\(data.partnerDisplayName ?? "Partner: N/A")")
                    .textStyle(TitleStyle())
                Text("Description: \(data.transactionDetail?.description ?? "N/A")")
                    .textStyle(FootNoteStyle())
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("gray6")))
            .padding(.horizontal, 20)
            .padding(.top, 120)
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
}
