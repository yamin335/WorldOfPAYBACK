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
    
    func loadTransactions(category: TransactionCategory) {
        showLoader()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.mockWaitingTime) {
            
            let randNum = Int.random(in: 1...1000)
            
            if randNum % 2 == 0 {
                let response: TransactionsResponse = JsonLoader.shared.loadLocalJsonFile(filename: "PBTransactions", ext: "json")
                if let list = response.items {
                    self.transactions = list.sorted {
                        $0.transactionDetail?.bookingDate ?? Date() > $1.transactionDetail?.bookingDate ?? Date()
                    }
                    
                    self.filterTransactions(by: category)
                }
                self.showSuccessMsg(msg: "Success!")
            } else {
                self.showErrorMsg(msg: "Failed! Some error occured.")
            }
            self.hideLoader()
        }
    }
    
    func filterTransactions(by category: TransactionCategory) {
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

    func invervalValuePublisher(array: [String]) -> AnyPublisher<String, Never> {
        let publishers = array
            .map { Just($0).delay(for: .seconds(1), scheduler: DispatchQueue.main).eraseToAnyPublisher() }
        return publishers[1...].reduce(publishers[0]) {
            Publishers.Concatenate(prefix: $0, suffix: $1).eraseToAnyPublisher()
        }
    }
}
