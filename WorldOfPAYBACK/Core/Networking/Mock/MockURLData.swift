//
//  MockUrlData.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct MockUrlData: Equatable {
    public let urlRequest: URLRequest
    public let responseResult: Result<MockUrlResponse, MockUrlError>

    public var urlResponse: URLResponse {
        get throws {
            switch responseResult {
            case .success(let response):
                guard let url = urlRequest.url else { throw MockUrlError.invalidRequestUrl }
                
                guard let response = HTTPURLResponse(
                    url: url,
                    statusCode: response.statusCode,
                    httpVersion: response.httpVersion,
                    headerFields: (urlRequest.allHTTPHeaderFields ?? [:]).merging(response.headers) { $1 }
                ) else {
                    throw MockUrlError.invalidHttpUrlResponse
                }
                       
                return response
            case .failure(let error):
                throw error
            }
        }
    }
}
