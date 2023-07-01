//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = TransactionsViewModel()
    @State var selectedCategoryLabel: String = TransactionCategory.all.title
    
    var body: some View {
        BaseView(viewModel: viewModel) {
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
                                        self.viewModel.category = category
                                        selectedCategoryLabel = category.title
                                        viewModel.filterTransactions()
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
                            .frame(width: 140)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("textColor4")))
                                
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    
                    List {
                        ForEach(Array($viewModel.filteredTransactions.wrappedValue.enumerated()), id: \.offset) { index, data in
                            NavigationLink(destination: TransactionDetailsView(data: data)) {
                                TransactionListItem(data: data)
                            }
                            .listRowSeparator(.hidden, edges: .all)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 12)
                            .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("gray6")))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        if self.appState.isConnected {
                            await viewModel.loadTransactions()
                        } else {
                            self.viewModel.showErrorMsg(msg: AppConstants.networkErrorMsg)
                        }
                    }
                    .overlay {
                        viewModel.filteredTransactions.count > 0 ? TransactionSumView(viewModel: viewModel) : nil
                    }
                    .overlay {
                        viewModel.filteredTransactions.count > 0 ? nil : ListEmptyView()
                    }
                }.navigationTitle("All Transaction")
            }.onAppear {
                if self.appState.isConnected {
                    Task(priority: .high) {
                        await viewModel.loadTransactions()
                    }
                } else {
                    self.viewModel.showErrorMsg(msg: AppConstants.networkErrorMsg)
                }
            }
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
