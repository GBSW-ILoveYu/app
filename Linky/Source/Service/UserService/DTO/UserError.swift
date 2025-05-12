//
//  UserError.swift
//  Linky
//
//  Created by 박성민 on 5/10/25.
//

import Foundation

enum UserError: Error {
    case noToken
    case tokenRefreshFailed
    case refreshInProgress
    case serverError(UserErrorResponse)
    case networkError(String)
}
