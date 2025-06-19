//
//  Login.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/18/25.
//

import Foundation

struct Login {
    var email: String
    var password: String
}

struct LoginSuccessResponse: Codable {
    let message: String
    let accessToken: String
    let refreshToken: String
}
