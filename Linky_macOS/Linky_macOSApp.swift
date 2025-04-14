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
        } label: {
            Image("logo")
        }
        .menuBarExtraStyle(.window)
    }
}
