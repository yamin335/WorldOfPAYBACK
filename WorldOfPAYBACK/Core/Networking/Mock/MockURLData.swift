//
//  MockURLData.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct MockURLData: Equatable {
    public let urlRequest: URLRequest
    public let responseResult: Result<MockURLResponse, MockURLError>

    public var urlResponse: URLResponse {
        get throws {
            switch responseResult {
            case .success(let response):
                guard let url = urlRequest.url else { throw MockURLError.invalidRequestUrl }
                
                guard let response = HTTPURLResponse(
                    url: url,
                    statusCode: response.statusCode,
                    httpVersion: response.httpVersion,
                    headerFields: (urlRequest.allHTTPHeaderFields ?? [:]).merging(response.headers) { $1 }
                ) else {
                    throw MockURLError.invalidHttpUrlResponse
                }
                       
                return response
            case .failure(let error):
                throw error
            }
        }
    }
}
