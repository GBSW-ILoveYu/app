//
//  SharedKeyChain.swift
//  Linky
//
//  Created by 박성민 on 6/2/25.
//

import SwiftKeychainWrapper

struct SharedKeyChain {
    static let shared = KeychainWrapper(serviceName: "linky", accessGroup: "group.com.Linky.shared")
}
