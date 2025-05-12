//
//  AuthError.swift
//  Linky
//
//  Created by 박성민 on 5/4/25.
//

import Foundation

struct AuthErrorResponse : Decodable {
    let message : OneOrMany<String>
    let error: String
    let statusCode: Int
}
