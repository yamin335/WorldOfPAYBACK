//
//  NetworkRequest.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 01.07.23.
//

import Foundation

/// Protocol that specifies a `NetworkRequest`
public protocol NetworkRequestProtocol {
    associatedtype Response: Codable

    /// `URL` for the `NetworkRequest`
    var url: String? { get }
    
    /// `Type` of `NetworkRequest` e.g. (GET, POST, PUT)
    var type: NetworkRequestType { get }
    
    /// The HTTP headers to include with the request.
    var headers: Dictionary<String, String>? { get }
    
    /// The parameters to include with the request.
    var httpBodyParam: [String: Any]? { get }
    
    var queryParam: Dictionary<String, String?>? { get }
}
