//
//  SignUpAlertType.swift
//  Linky
//
//  Created by 박성민 on 5/5/25.
//

import Foundation

enum SignUpAlertType: Identifiable {
    case error(String)
    case success
    
    var id: String {
        switch self {
        case .error:
            return "error"
        case .success:
            return "success"
        }
    }
}
