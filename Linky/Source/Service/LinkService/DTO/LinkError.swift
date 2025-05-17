//
//  LinkError.swift
//  Linky
//
//  Created by 박성민 on 5/14/25.
//

import Foundation

enum LinkError: Error {
    case decodingError
    case missingUrlError
    case networkError
}
