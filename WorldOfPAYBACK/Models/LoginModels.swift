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
    let Account: UserAccount?
    let Token: LoginToken?
}

struct LoginToken: Codable {
    let AccessToken: String?
    let RefreshToken: String?
    let AccessUUID: String?
    let RefreshUUID: String?
    let AtExpires: UInt64?
    let RtExpires: UInt64?
}

struct RegisteredUsers: Codable {
    let users: [UserAccount]
}
