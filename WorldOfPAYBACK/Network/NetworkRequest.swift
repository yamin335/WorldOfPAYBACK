//
//  NetworkRequest.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 02.07.23.
//

import Foundation

public final class NetworkRequest<ResponseType : Codable>: NetworkRequestProtocol {
    public var url: String?
    
    public var type: NetworkRequestType
    
    public var headers: Dictionary<String, String>?
    
    public var httpBodyParam: [String : Any]?
    
    public var queryParam: Dictionary<String, String?>?
    
    public typealias Response = ResponseType
    
    init(url: String? = nil, type: NetworkRequestType, headers: Dictionary<String, String>? = [:], httpBodyParam: [String : Any]? = [:], queryParam: Dictionary<String, String?>? = [:]) {
        
        self.url = url
        self.type = type
        self.headers = headers
        self.httpBodyParam = httpBodyParam
        self.queryParam = queryParam
    }
}
