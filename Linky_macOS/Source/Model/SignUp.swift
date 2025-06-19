//
//  SignUp.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/18/25.
//

import Foundation

struct SignUp {
    var name: String
    var id : String
    var password: String
    var passwordCheck: String
    var email: String 
}

struct SignUpSuccessResponse: Codable {
    let message: String
}
