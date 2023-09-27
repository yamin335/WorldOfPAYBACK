//
//  HttpError.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public enum HttpError: Swift.Error, Equatable {
    case invalidRequestUrl
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
}
