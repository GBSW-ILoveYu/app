//
//  UserError.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation

struct UserErrorResponse : Decodable{
    let message: String
    let statusCode: Int
}
