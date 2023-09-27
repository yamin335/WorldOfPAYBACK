//
//  AppEnvironment.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

public enum AppEnvironment {
    case mock
    case staging
    case release
    
    static let current: Self = {
        #if DEBUG
        return .mock
        #else
        return .release
        #endif
    }()
    
    var baseUrl: URL {
        switch self {
        case .mock:
            return URL(string: "https://api-test.payback.com")!
        case .staging:
            return URL(string: "https://api-test.payback.com")!
        case .release:
            return URL(string: "https://api.payback.com")!
        }
    }
}
