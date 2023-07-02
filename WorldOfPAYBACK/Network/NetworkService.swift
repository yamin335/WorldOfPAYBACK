//
//  NetworkService.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 01.07.23.
//

import Foundation
import Combine

/// A service that can perform network requests.
public protocol NetworkServiceProtocol {
    /// Performs the given network request and returns a publisher that emits either the decoded response or an error.
    ///
    /// - Parameter request: The network request to perform.
    func perform<T: NetworkRequestProtocol>(_ request: T) -> AnyPublisher<T.Response, NetworkError>
}

/// Protocol defining necessary URLSession functionality for the `NetworkService`.
public protocol URLSessionProtocol {
    /// Returns a publisher that wraps a URL session data task for a given URL request.
    ///
    /// - Parameter request: The URL request to perform.
    /// - Returns: A publisher that emits a tuple of the data and URL response, or an error.
    func sessionDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

/// Extension to make `URLSession` conform to `URLSessionProtocol`.
extension URLSession: URLSessionProtocol {
    public func sessionDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return self.dataTaskPublisher(for: request)
            .map { ($0.data, $0.response) }
            .eraseToAnyPublisher()
    }
}

/// A service that handles network requests.
public final class NetworkService: NetworkServiceProtocol {

    private let urlSession: URLSessionProtocol

    /// Creates a new instance of `NetworkService`.
    ///
    /// - Parameter urlSession: The URL session to use for the network requests. Defaults to `URLSession.shared`.
    public init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    /// Performs the given network request and returns a publisher that emits either the decoded response or an error.
    ///
    /// - Parameter request: The network request to perform.
    public func perform<T>(_ request: T) -> AnyPublisher<T.Response, NetworkError> where T : NetworkRequestProtocol {
        
        guard let stringUrl = request.url, var urlComponents = URLComponents(string: stringUrl) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        var queryItems = [URLQueryItem]()
        
        if let queryParams = request.queryParam {
            for item in queryParams {
                queryItems.append(URLQueryItem(name: item.key, value: item.value))
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.type.rawValue
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = request.httpBodyParam {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: NetworkError.encodingError).eraseToAnyPublisher()
            }
        }
        
        return urlSession.sessionDataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.serverError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }
                return data
            }
            .retry(1)
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError, urlError.code == URLError.notConnectedToInternet {
                    return NetworkError.noInternetError
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknownError
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
