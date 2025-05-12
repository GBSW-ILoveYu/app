//
//  TokenResponse.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
