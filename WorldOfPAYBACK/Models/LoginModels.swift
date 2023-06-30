//
//  LoginModels.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

import Foundation

struct UserAccount: Codable {
    let id: Int?
    let email: String?
    let password: String?
    let retypepassword: String?
}

struct LoginResponse: Codable {
    let code: Int?
    let data: LoginResponseData?
    let msg: String?
}

struct LoginResponseData: Codable {
    let account: UserAccount?
    let token: LoginToken?
}

struct LoginToken: Codable {
    let accessToken: String?
    let refreshToken: String?
    let accessUUID: String?
    let refreshUUID: String?
    let atExpires: UInt64?
    let rtExpires: UInt64?
}

struct RegisteredUsers: Codable {
    let users: [UserAccount]
}
