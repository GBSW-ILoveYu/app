//
//  LoginRequest.swift
//  Linky
//
//  Created by 박성민 on 5/5/25.
//

import Foundation

struct LoginRequest: Encodable{
    let email: String
    let password: String
}
