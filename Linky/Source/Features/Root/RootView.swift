//
//  RootView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var pathModel = PathModel()
    //TODO: - 로그인 체크 모델 넣기
    
    var body: some View {
        NavigationStack(path: $pathModel.paths){
            VStack{
                Text("여기다 스플래시 뷰 넣어야겠당")
            }.onAppear{
                pathModel.paths.append(.login)
            }
            .navigationDestination(for: PathType.self) { route in
                switch route{
                case .login:
                    LoginView()
                        .navigationBarBackButtonHidden()
                case .signUp:
                    SignUpView()
                case .main:
                    MainView()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

#Preview {
    RootView()
}
