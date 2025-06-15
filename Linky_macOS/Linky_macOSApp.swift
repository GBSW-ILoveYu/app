//
//  Linky_macOSApp.swift
//  Linky_macOS
//
//  Created by 박성민 on 4/14/25.
//

import SwiftUI

enum ViewPath {
    case main
    case login
    case signup
}

class AppViewModel: ObservableObject{
    @Published var currentView: ViewPath = .main
    var dynamicHeight: CGFloat {
        switch currentView {
        case .main:
            return 228
        case .login:
            return 380
        case .signup:
            return 600
        }
    }
}

@main
struct Linky_macOSApp: App {
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            MainView()
                .environmentObject(viewModel)
                .frame(width: 400, height: viewModel.dynamicHeight)
        } label: {
            Image("logo")
        }
        .menuBarExtraStyle(.window)
    }
}

