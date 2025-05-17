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
    var linkService: LinkServiceType { get set }
}

class Services: ServiceType{
    var authService: AuthServiceType
    var userService: UserServiceType
    var linkService: LinkServiceType
    init() {
        self.authService = AuthService()
        self.userService = UserService()
        self.linkService = LinkService()
    }
}

class StubServices: ServiceType{
    var authService: AuthServiceType = StubAuthService()
    var userService: UserServiceType = StubUserService()
    var linkService: LinkServiceType = StubLinkService()
}
