//
//  LoginAlertType.swift
//  Linky
//
//  Created by 박성민 on 5/9/25.
//

import Foundation

enum LoginAlertType: Identifiable{
    case error(String)
    case success
    
    var id: String {
        switch self {
        case .error(let string):
            return "error"
        case .success:
            return "success"
        }
    }
}
