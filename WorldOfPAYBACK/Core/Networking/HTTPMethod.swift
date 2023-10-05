//
//  HTTPMethod.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public enum HTTPMethod: Equatable {
    case get
    case post(Data?)
    
    var httpMethod: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .get:
            return nil
        case let .post(bodyData):
            return bodyData
        }
    }
}
