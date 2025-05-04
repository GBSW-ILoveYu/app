//
//  SIgnUpRequest.swift
//  Linky
//
//  Created by 박성민 on 5/4/25.
//

import Foundation

struct SignUpRequest : Encodable {
    let email: String
    let password: String
    let nickName: String
    let userId: String
}
