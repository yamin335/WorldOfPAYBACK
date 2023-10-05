//
//  MockURLProtocol.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public final class MockURLProtocol: URLProtocol {
    static var mocks: [URLRequest: MockURLData] = [:]
    static var shouldCheckQueryParameters = false

    override public class func canInit(with request: URLRequest) -> Bool {
        mocks[request] != nil
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    public class func add(mock: MockURLData) {
        mocks[mock.urlRequest] = mock
    }

    public override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        guard let mock = Self.mocks[request] else {
            client?.urlProtocol(self, didFailWithError: MockURLError.requestNotFound)
            return
        }
        
        do {
            let urlResponse = try mock.urlResponse
            if let data = try mock.responseResult.get().data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    public override func stopLoading() { }
}
