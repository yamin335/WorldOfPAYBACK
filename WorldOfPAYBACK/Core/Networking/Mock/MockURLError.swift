//
//  MockUrlError.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public enum MockUrlError: Swift.Error {
    case invalidRequestUrl
    case invalidResource
    case invalidHttpUrlResponse
    case requestNotFound
}
