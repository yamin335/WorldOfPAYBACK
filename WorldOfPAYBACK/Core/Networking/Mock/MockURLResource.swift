//
//  MockUrlResource.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public struct MockUrlResource {
    public typealias MockUrlResourceResult = Result<ResourceType, MockUrlError>
    public enum ResourceType {
        case file(jsonName: String)
    }
    
    public let result: MockUrlResourceResult
}
