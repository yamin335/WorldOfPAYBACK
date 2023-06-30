//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct TransactionView: View {
    @StateObject var viewModel = TransactionsViewModel()
    @State var category: TransactionCategory = .all
    @State var selectedCategoryLabel: String = TransactionCategory.all.title
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Spacer()
                    Text("Transaction Type:")
                        .foregroundColor(Color("textColor4"))
                    Menu {
                        ForEach(TransactionCategory.allCases, id: \.self) { category in
                            Button(action: {
                                withAnimation {
                                    selectedCategoryLabel = category.title
                                    viewModel.filterTransactions(by: category)
                                }
                            }) {
                                Text("\(category.title)")
                            }
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text(selectedCategoryLabel)
                                .foregroundColor(Color("textColor3"))
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color("textColor3"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("textColor4")))
                            
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 15)
                
                
                Spacer()
                
                HStack(spacing: 10) {
                    Text("Total transaction amount:")
                        .foregroundColor(.white)
                    Text("\($viewModel.sumOfTransaction.wrappedValue.formatted(.currency(code: $viewModel.currency.wrappedValue)))")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("blue2")).cornerRadius(10).shadow(color: Color("shadowColor"), radius: 6, x: 1, y: 2))
        
                .padding()
                
            }.navigationTitle("All Transaction")
        }.onAppear {
            viewModel.loadTransactions(category: category)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
