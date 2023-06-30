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
                .padding(.top, 0)
                .padding(.bottom, 0)
                
                ScrollView {
                    VStack(spacing:0) {
                        ForEach(Array($viewModel.filteredTransactions.wrappedValue.enumerated()), id: \.offset) { index, data in
                            NavigationLink(destination: TransactionDetailsView(data: data)) {
                                TransactionListItem(data: data)
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
                .overlay {
                    $viewModel.filteredTransactions.count > 1 ? TransactionSumView(viewModel: viewModel) : nil
                }
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
