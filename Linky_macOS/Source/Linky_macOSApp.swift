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

@main
struct Linky_macOSApp: App {
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            MainView()
                .environmentObject(viewModel)
                .frame(width: 400, height: viewModel.dynamicHeight)
                .onAppear{
                    
                }
        } label: {
            Image("logo")
                .resizable()
                .frame(width: 10)
        }
        .menuBarExtraStyle(.window)
    }
}

