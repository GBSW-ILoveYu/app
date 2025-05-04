//
//  LinkyApp.swift
//  Linky
//
//  Created by 박성민 on 3/19/25.
//

import SwiftUI

@main
struct LinkyApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init())
                .environmentObject(container)
        }
    }
}
