//
//  AuthError.swift
//  Linky
//
//  Created by 박성민 on 5/4/25.
//

import Foundation

struct AuthError : Decodable, Error {
    let message : OneOrMany<String>
    let error: String
    let statusCode: Int
}
