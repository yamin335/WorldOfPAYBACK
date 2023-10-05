//
//  URLResource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct URLResource<T> {
    let path: String
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let mock: MockURLResource?
    let decode: (Data?) throws -> T
    
    static func get<DTO: Decodable>(
        path: String,
        headers: HTTPHeaders? = nil,
        mock: MockURLResource? = nil,
        decoder: JSONDecoder
    ) -> URLResource<DTO> {
        return URLResource<DTO>(
            path: path,
            method: .get,
            headers: headers,
            mock: mock,
            decode: { data in
                guard let data = data else {
                    throw DecodingError.valueNotFound(
                        DTO.self,
                        DecodingError.Context(
                            codingPath: [],
                            debugDescription: "\(DTO.self)"
                        )
                    )
                }
                return try decoder.decode(DTO.self, from: data)
            }
        )
    }
    
    static func post<RequestEntity: Encodable, ResponseEntity: Decodable>(
        path: String,
        entity: RequestEntity,
        headers: HTTPHeaders? = nil,
        mock: MockURLResource? = nil,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) -> URLResource<ResponseEntity>? {
        guard let data = try? encoder.encode(entity) else {
            return nil
        }
        
        return URLResource<ResponseEntity>(
            path: path,
            method: .post(data),
            headers: headers,
            mock: mock,
            decode: { data in
                guard let data = data else {
                    throw DecodingError.valueNotFound(
                        ResponseEntity.self,
                        DecodingError.Context(
                            codingPath: [],
                            debugDescription: "\(ResponseEntity.self)"
                        )
                    )
                }
                return try decoder.decode(ResponseEntity.self, from: data)
            }
        )
    }
}
