//
//  Services.swift
//  Linky
//
//  Created by 박성민 on 5/1/25.
//

import Foundation

protocol ServiceType {
    var authService: AuthServiceType { get set }
    var userService: UserServiceType { get set }
}

class Services: ServiceType{
    var authService: AuthServiceType
    var userService: UserServiceType
    init() {
        self.authService = AuthService()
        self.userService = UserService()
    }
}

class StubServices: ServiceType{
    var authService: AuthServiceType = StubAuthService()
    var userService: UserServiceType = StubUserService()
}
