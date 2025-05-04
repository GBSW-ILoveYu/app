//
//  LoginResponse.swift
//  Linky
//
//  Created by 박성민 on 5/5/25.
//

import Foundation

struct LoginSuccessResponse: Decodable {
    let message: String
    let accessToken: String
    let refreshToken: String
}
