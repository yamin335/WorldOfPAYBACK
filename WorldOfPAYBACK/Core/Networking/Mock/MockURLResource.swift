//
//  MockURLResource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct MockURLResource {
    public typealias MockURLResourceResult = Result<ResourceType, MockURLError>
    public enum ResourceType {
        case file(jsonName: String)
    }
    
    public let result: MockURLResourceResult
}
