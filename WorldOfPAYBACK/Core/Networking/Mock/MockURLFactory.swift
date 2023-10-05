//
//  MockUrlFactory.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public protocol MockUrlFactoryType {
    func addMock<DTO>(for request: URLRequest, with resource: UrlResource<DTO>)
}

public struct MockUrlFactory: MockUrlFactoryType {
    private let environment: AppEnvironment
    
    public func addMock<DTO>(for request: URLRequest, with resource: UrlResource<DTO>) {
        guard environment == .mock,
        let resourceMock = resource.mock else { return }
        
        let mockResponseResult: Result<MockUrlResponse, MockUrlError>
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
                    MockUrlResponse(statusCode: 200, httpVersion: "HTTP/1.1", data: data, errorCode: nil, headers: [:])
                )
            }
        case .failure(let error):
            mockResponseResult = .failure(error)
        }
        
        let mock = MockUrlData(urlRequest: request, responseResult: mockResponseResult)
        MockUrlProtocol.add(mock: mock)
    }
}
