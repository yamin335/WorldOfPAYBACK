//
//  TransactionSumView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI
import Combine

struct TransactionSumView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 10) {
                Text("Total amount:")
                    .foregroundColor(.white)
                Text("\($viewModel.sumOfTransaction.wrappedValue.formatted(.currency(code: $viewModel.currency.wrappedValue)))")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("blue2")).cornerRadius(10).shadow(color: Color("shadowColor"), radius: 6, x: 1, y: 2))
    
            .padding()
        }
        .background(.clear)
    }
}
