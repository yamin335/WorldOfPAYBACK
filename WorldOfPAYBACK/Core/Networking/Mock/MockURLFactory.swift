//
//  MockURLFactory.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public protocol MockURLFactoryType {
    func addMock<DTO>(for request: URLRequest, with resource: URLResource<DTO>)
}

public struct MockURLFactory: MockURLFactoryType {
    private let environment: AppEnvironment
    
    public func addMock<DTO>(for request: URLRequest, with resource: URLResource<DTO>) {
        guard environment == .mock,
        let resourceMock = resource.mock else { return }
        
        let mockResponseResult: Result<MockURLResponse, MockURLError>
        switch resourceMock.result {
        case .success(let resourceType):
            switch resourceType {
            case .file(let jsonName):
                guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json"),
                      let data = try? Data(contentsOf: url) else {
                    mockResponseResult = .failure(.invalidResource)
                    break
                }
                
                mockResponseResult = .success(
                    MockURLResponse(statusCode: 200, httpVersion: "HTTP/1.1", data: data, errorCode: nil, headers: [:])
                )
            }
        case .failure(let error):
            mockResponseResult = .failure(error)
        }
        
        let mock = MockURLData(urlRequest: request, responseResult: mockResponseResult)
        MockURLProtocol.add(mock: mock)
    }
}
