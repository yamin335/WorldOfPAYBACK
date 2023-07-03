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
                    filterView
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    
                    listView
                }.navigationTitle("All Transaction")
            }.task {
                await loadData(isRefreshing: false)
            }
        }
    }
    
    private var filterView: some View {
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
            .disabled(viewModel.filteredTransactions.isEmpty)
            .opacity(viewModel.filteredTransactions.isEmpty ? 0.3 : 1)
        }
    }
    
    private var listView: some View {
        List {
            ForEach(Array(viewModel.filteredTransactions.enumerated()), id: \.offset) { index, data in
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
            await loadData(isRefreshing: true)
        }
        .overlay {
            viewModel.filteredTransactions.count > 0 ? TransactionSumView(viewModel: viewModel) : nil
        }
        .overlay {
            viewModel.filteredTransactions.count > 0 ? nil : ListEmptyView()
        }
    }
    
    private func loadData(isRefreshing: Bool) async {
        if self.appState.isConnected {
            await viewModel.loadTransactions(isRefreshing: isRefreshing)
        } else {
            self.viewModel.showErrorMsg(msg: AppConstants.networkErrorMsg)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
