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
    
    /// This `AnyCancellable` will be used to get data from real `API` call
    private var dataSubscriber: AnyCancellable? = nil
    var transactionDataPublisher = PassthroughSubject<TransactionsResponse, Never>()
    
    deinit {
        dataSubscriber?.cancel()
    }
    
    func loadTransactions() async {
        showLoader()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.mockWaitingTime) {
            
            let randNum = Int.random(in: 1...1000)
            
            if randNum % 2 == 0 {
                let response: TransactionsResponse = JsonLoader.shared.loadLocalJsonFile(filename: "PBTransactions", ext: "json")
                if let list = response.items {
                    self.transactions = list.sorted {
                        $0.transactionDetail?.bookingDate ?? Date() > $1.transactionDetail?.bookingDate ?? Date()
                    }
                    
                    self.filterTransactions()
                }
                self.showSuccessMsg(msg: "Success!")
            } else {
                self.showErrorMsg(msg: "Failed! Some error occured.")
                self.transactions = []
                self.filteredTransactions = []
            }
            self.hideLoader()
        }
    }
    
    func filterTransactions() {
        filteredTransactions = category == .all ? transactions : transactions.filter { $0.category == category.rawValue }
        
        sumOfTransaction = filteredTransactions.reduce(0) { x, y in
            var amount = 0
            if let val = y.transactionDetail?.value?.amount {
                amount = val
            }
            return x + amount
        }
        
        if !filteredTransactions.isEmpty {
            currency = filteredTransactions.first?.transactionDetail?.value?.currency?.lowercased() ?? AppConstants.defaultCurrency
        }
    }

    /// This function will be used to initiate a real network call to the `Transaction API` in order to get data
    func requestTransactionData() {
        self.dataSubscriber = ApiService.getTransactionList(partnerId: 0, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                    self.showErrorMsg(msg: error.localizedDescription)
                }
            }, receiveValue: { transactionDataResponse in
                if transactionDataResponse.code == RequestHelper.successCode {
                    self.showSuccessMsg(msg: "Success!")
                    // Send data to all observers that you set for this data publisher
                    self.transactionDataPublisher.send(transactionDataResponse)
                    // Update list
                    DispatchQueue.main.async {
                        if let list = transactionDataResponse.items {
                            self.transactions = list.sorted {
                                $0.transactionDetail?.bookingDate ?? Date() > $1.transactionDetail?.bookingDate ?? Date()
                            }
                            
                            self.filterTransactions()
                        }
                    }
                } else {
                    self.showErrorMsg(msg: "Failed! Some error occured.")
                }
            })
    }
}
