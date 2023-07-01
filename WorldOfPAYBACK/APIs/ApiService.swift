//
//  ApiService.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import Combine

class ApiService {
    enum APIFailureCondition: Error {
        case InvalidServerResponse
    }
    
    static func getTransactionList(partnerId: Int, viewModel: BaseViewModel) -> AnyPublisher<TransactionsResponse, Error>? {
        let jsonObject = ["partnerId": partnerId]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: RequestHelper.allTransactions) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = RequestHelper.getCommonUrlRequest(url: url)
        request.httpMethod = "GET"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func getDataTask<T: Codable>(request: URLRequest, viewModel: BaseViewModel) -> AnyPublisher<T, Error>? {
        return viewModel.urlSession.dataTaskPublisher(for: request)
            .handleEvents(receiveSubscription: { _ in
                viewModel.showLoader()
            }, receiveOutput: { _ in
                viewModel.hideLoader()
            }, receiveCompletion: { _ in
                viewModel.hideLoader()
            }, receiveCancel: {
                viewModel.hideLoader()
            })
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw ApiService.APIFailureCondition.InvalidServerResponse
                }
            
                return data
        }
        .retry(1)
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
