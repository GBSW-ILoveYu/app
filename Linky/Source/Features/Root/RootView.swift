//
//  RootView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var pathModel = PathModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths){
            VStack{
                ProgressView()
            }
            .onAppear{
                pathModel.paths.append(.login)
            }
            .navigationDestination(for: PathType.self) { route in
                switch route {
                case .login:
                    LoginView()
                        .navigationBarBackButtonHidden()
                case .signUp:
                    SignUpView()
                        .navigationBarBackButtonHidden()
                case .main:
                    MenuView()
                        .navigationBarBackButtonHidden()
                case .upload:
                    UploadOkVIew()
                        .navigationBarBackButtonHidden()
                case .categoryDetail(let category):
                    CategoryDetailView(category: category)
                        .navigationBarBackButtonHidden()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

#Preview {
    RootView()
}
