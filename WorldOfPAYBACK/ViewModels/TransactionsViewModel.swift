//
//  TransactionsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import Foundation
import Combine

class TransactionsViewModel: BaseViewModel {
    
    @Published var transactions: [Transaction] = []
    @Published var filteredTransactions: [Transaction] = []
    @Published var sumOfTransaction: Int = 0
    @Published var currency: String = AppConstants.defaultCurrency
    @Published var category: TransactionCategory = .all
    
    //var publisher = PassthroughSubject<[Transaction], Never>()
    
    /// This `AnyCancellable` will be used to get data from real `API` call
    private var dataSubscriber: AnyCancellable? = nil
    var transactionDataPublisher = PassthroughSubject<TransactionsResponse, Never>()
    
    deinit {
        dataSubscriber?.cancel()
    }
    
    @MainActor
    func loadTransactions(isRefreshing: Bool) async {
        if !isRefreshing {showLoader()}
        try? await Task.sleep(for: .seconds(AppConstants.mockWaitingTime))
        let randNum = Int.random(in: 1...1000)
        
        if randNum % 2 != 0 {
            self.showErrorMsg(msg: "Transactions loading failed due to error!")
            self.transactions = []
            self.filteredTransactions = []
            self.sumOfTransaction = 0
            hideLoader()
            return
        }
        
        let list = await load()
        let filtered = category == .all ? list : filter(category: category, transactions: list)
        let sum = calculateSum(transactions: filtered)
        self.transactions = list
        self.filteredTransactions = filtered
        self.sumOfTransaction = sum
        self.currency = self.getCurrencyForTotal(transactions: filtered)
        self.showSuccessMsg(msg: "Transactions successfully loaded!")
        hideLoader()
    }
    
    func filterTransactions() {
        let filtered = category == .all ? self.transactions : filter(category: category, transactions: self.transactions)
        let sum = calculateSum(transactions: filtered)
        self.sumOfTransaction = sum
        self.filteredTransactions = filtered
        self.currency = self.getCurrencyForTotal(transactions: filtered)
    }
    
    private func load() async -> [Transaction] {
        let response: TransactionsResponse = JsonLoader.shared.loadLocalJsonFile(filename: "PBTransactions", ext: "json")
        if let list = response.items {
            let transactions = list.sorted {
                $0.transactionDetail?.bookingDate ?? Date() > $1.transactionDetail?.bookingDate ?? Date()
            }
            
            return transactions
        }
        return []
    }
    
    private func filter(category: TransactionCategory, transactions: [Transaction]) -> [Transaction] {
        return transactions.filter { $0.category == category.rawValue }
    }
    
    private func calculateSum(transactions: [Transaction]) -> Int {
        return transactions.reduce(0) { x, y in
            var amount = 0
            if let val = y.transactionDetail?.value?.amount {
                amount = val
            }
            return x + amount
        }
    }
    
    private func getCurrencyForTotal(transactions: [Transaction]) -> String {
        return transactions.isEmpty ? "" : transactions.first?.transactionDetail?.value?.currency?.lowercased() ?? AppConstants.defaultCurrency
    }

    /// This function will be used to initiate a real network call to the `Transaction API` in order to get data
    func requestTransactionData() {
        self.dataSubscriber = ApiService.loadTransactions(email: "", partnerId: "")?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                    self.showErrorMsg(msg: error.localizedDescription)
                }
            }, receiveValue: { transactionDataResponse in
                if transactionDataResponse.code == RequestHelper.successCode {
                    self.showSuccessMsg(msg: "Transactions successfully loaded")
                    // Send data to all observers that you set for this data publisher
                    self.transactionDataPublisher.send(transactionDataResponse)
                    // Update list here
                } else {
                    self.showErrorMsg(msg: "Transactions loading failed due to error!")
                }
            })
    }
}
