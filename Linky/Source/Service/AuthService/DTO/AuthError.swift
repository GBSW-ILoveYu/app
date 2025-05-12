//
//  Autherror.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation

enum AuthError: Error {
    case apiError(AuthErrorResponse)
    case decodingError(String)
    case networkError(String)
    case unknown(String)             
}
