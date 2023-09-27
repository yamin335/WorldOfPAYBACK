//
//  UrlResource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct UrlResource<T> {
    let path: String
    let method: HttpMethod
    let headers: HttpHeaders?
    let mock: MockUrlResource?
    let decode: (Data?) throws -> T
    
    static func get<DTO: Decodable>(
        path: String,
        headers: HttpHeaders? = nil,
        mock: MockUrlResource? = nil,
        decoder: JSONDecoder
    ) -> UrlResource<DTO> {
        return UrlResource<DTO>(
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
        headers: HttpHeaders? = nil,
        mock: MockUrlResource? = nil,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) -> UrlResource<ResponseEntity>? {
        guard let data = try? encoder.encode(entity) else {
            return nil
        }
        
        return UrlResource<ResponseEntity>(
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
