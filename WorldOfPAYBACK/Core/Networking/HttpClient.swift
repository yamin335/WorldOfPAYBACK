//
//  HttpClient.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public protocol HttpClientType {
    func fetch<DTO>(resource: UrlResource<DTO>) async throws -> DTO
}

public final class HttpClient: HttpClientType {
    private let baseUrl: URL
    private let mockUrlFactory: MockUrlFactoryType
    private let session: URLSession

    public init(
        baseUrl: URL,
        mockUrlFactory: MockUrlFactoryType
    ) {
        self.baseUrl = baseUrl
        self.mockUrlFactory = mockUrlFactory
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockUrlProtocol.self]
        self.session = URLSession(configuration: sessionConfiguration)
    }

    public func fetch<Entity>(resource: UrlResource<Entity>) async throws -> Entity {
        guard let url = URL(string: resource.path, relativeTo: baseUrl) else {
            throw HttpError.invalidRequestUrl
        }

        let request = createRequest(url: url, method: resource.method, headers: resource.headers)
        mockUrlFactory.addMock(for: request, with: resource)
        
        let (data, urlResponse) = try await session.data(for: request)

        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }

        guard (200..<400).contains(httpURLResponse.statusCode) else {
            throw HttpError.invalidStatusCode(statusCode: httpURLResponse.statusCode)
        }

        return try resource.decode(data)
    }
    
    private func createRequest(
        url: URL,
        method: HttpMethod,
        headers: HttpHeaders?
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.httpMethod
        request.httpBody = method.httpBody
        return request
    }
}
