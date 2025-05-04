//
//  DIContainer.swift
//  Linky
//
//  Created by 박성민 on 5/1/25.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = Services()
    }
}
