//
//  MockUrlResponse.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct MockUrlResponse: Equatable {
    public let statusCode: Int
    public let httpVersion: String
    public let data: Data?
    public let errorCode: URLError.Code?
    public let headers: [String: String]
}
