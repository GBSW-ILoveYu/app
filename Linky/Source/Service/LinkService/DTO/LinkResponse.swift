//
//  LinkResponse.swift
//  Linky
//
//  Created by 박성민 on 5/14/25.
//

import Foundation

struct linkUser : Decodable {
    let id : Int
    let nickName: String
    let imageUri: String?
}
struct LinkResponse: Decodable {
    let id : Int
    let url: String
    let category: String
    let title: String
    let description: String
    let thumbnail: String
    let createdAt: String
    let updatedAt: String
    let user: linkUser
}
