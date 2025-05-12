//
//  User.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation

struct User : Decodable{
    var id: Int
    var loginType: String
    var email: String
    var userId: String
    var nickName: String
    var imageUrl: String?
}
