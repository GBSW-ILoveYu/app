//
//  Services.swift
//  Linky
//
//  Created by 박성민 on 5/1/25.
//

import Foundation

protocol ServiceType {
    var authService: AuthServiceType { get set }
}

class Services: ServiceType{
    var authService: AuthServiceType
    
    init() {
        self.authService = AuthService()
    }
}

class StubServices: ServiceType{
    var authService: AuthServiceType = StubAuthService()
}
