//
//  MockURLError.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public enum MockURLError: Swift.Error, Equatable {
    case invalidRequestUrl
    case invalidResource
    case invalidHttpUrlResponse
    case requestNotFound
}
