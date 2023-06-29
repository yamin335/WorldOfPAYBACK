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
    
    static func login(email: String, password: String, viewModel: BaseViewModel) -> AnyPublisher<LoginResponse, Error>? {
        let jsonObject = ["email": email, "password": password]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.login) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func signUp(userName: String, password: String, email: String,
                       userType: Int, firstName: String, lastName: String,
                       company: String, mobile: String, reTypePassword: String,
                       fullName: String, type: String, role: String, viewModel: BaseViewModel) -> AnyPublisher<SignUpResponse, Error>? {
        let jsonObject = [
            "username": userName,
            "password": password,
            "email": email,
            "usertype": userType,
            "firstname": firstName,
            "lastname": lastName,
            "company": company,
            "mobile": mobile,
            "retypepassword": reTypePassword,
            "fullname": fullName,
            "type": type,
            "role": role
        ] as [String : Any]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.signUp) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func submitQuotation(quotationStoreBody: SummaryStoreModel, viewModel: BaseViewModel) -> AnyPublisher<SummaryResponse, Error>? {
        
        guard let data = try? JSONEncoder().encode(quotationStoreBody) else {
            print("Problem in JSONData creation...")
            return nil
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        
        print(json)
        
//        guard let jsonString = String(data: json, encoding: String.Encoding.ascii) else {
//            return nil
//        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.submitQuotation) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = data
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func updateQuotation(quotationUpdateBody: SummaryResponseQuotation, viewModel: BaseViewModel) -> AnyPublisher<QuotationUpdateResponse, Error>? {
        
        guard let data = try? JSONEncoder().encode(quotationUpdateBody) else {
            print("Problem in JSONData creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.updateQuotation) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = data
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func allProducts(viewModel: BaseViewModel) -> AnyPublisher<AllProductsResponse, Error>? {
        
        guard let urlComponents = URLComponents(string: NetworkUtils.allProducts) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func productDetails(productId: String, viewModel: BaseViewModel) -> AnyPublisher<ServiceModuleResponse, Error>? {
        let jsonObject = ["productid": productId]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.productDetails) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func myQuotations(email: String, page: String, viewModel: BaseViewModel) -> AnyPublisher<QuotationListResponse, Error>? {
        let jsonObject = ["email": email]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "page", value: page))
        
        guard var urlComponents = URLComponents(string: NetworkUtils.myQuotations) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func quotationDetails(quotationId: String, viewModel: BaseViewModel) -> AnyPublisher<QuotationDetailsResponse, Error>? {
        let jsonObject = ["quotationid": quotationId]
        
        if !JSONSerialization.isValidJSONObject(jsonObject) {
            print("Problem in parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem in parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkUtils.myQuotationDetails) else {
            print("Problem in UrlComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        //Request type
        var request = NetworkUtils.getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        //Setting body for POST request
        request.httpBody = jsonData
        
        return getDataTask(request: request, viewModel: viewModel)
    }
    
    static func getDataTask<T: Codable>(request: URLRequest, viewModel: BaseViewModel) -> AnyPublisher<T, Error>? {
        return viewModel.session.dataTaskPublisher(for: request)
            .handleEvents(receiveSubscription: { _ in
                viewModel.showLoader.send(true)
            }, receiveOutput: { _ in
                viewModel.showLoader.send(false)
            }, receiveCompletion: { _ in
                viewModel.showLoader.send(false)
            }, receiveCancel: {
                viewModel.showLoader.send(false)
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
