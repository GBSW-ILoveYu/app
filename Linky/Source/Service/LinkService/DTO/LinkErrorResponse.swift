//
//  LinkErrorResponse.swift
//  Linky
//
//  Created by 박성민 on 5/28/25.
//

import Foundation

struct LinkErrorResponse : Decodable{
    let message : OneOrMany<String>
    let error: String
    let statusCode: Int
}
