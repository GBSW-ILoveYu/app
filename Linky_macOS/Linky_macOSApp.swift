//
//  Linky_macOSApp.swift
//  Linky_macOS
//
//  Created by 박성민 on 4/14/25.
//

import SwiftUI

@main
struct Linky_macOSApp: App {

    var body: some Scene {
        MenuBarExtra {
            macosApp()
                .frame(width: 512, height: 228)
        } label: {
            Image("logo")
        }
        .menuBarExtraStyle(.window)
    }
}

