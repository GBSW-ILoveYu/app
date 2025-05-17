//
//  PathType.swift
//  Linky
//  Created by 박성민 on 3/20/25.
//

enum PathType: Hashable{
    case login
    case signUp
    case main
    case categoryDetail(Category)
}
