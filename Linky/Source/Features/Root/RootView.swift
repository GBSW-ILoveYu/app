//
//  RootView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: RootViewModel
    var body: some View {
        NavigationStack(path: $viewModel.paths){
            VStack{
                ProgressView()
            }
            
            .onAppear{
                //TODO: LoginCheck 로직
                viewModel.send(action: .push(.login))
            }
            
            .navigationDestination(for: PathType.self) { route in
                switch route {
                case .login:
                    LoginView(viewModel: .init(container: container, pathModel: viewModel))
                        .navigationBarBackButtonHidden()
                    
                case .signUp:
                    SignUpView(viewModel: .init(container: container))
                        .navigationBarBackButtonHidden()
                        
                case .main:
                    MenuView(viewModel: .init(container: container))
                        .navigationBarBackButtonHidden()
                    
                case .categoryDetail(let category):
                    CategoryDetailView(category: category, viewModel: .init(container: container))
                        .navigationBarBackButtonHidden()
                }
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    RootView(viewModel: .init())
        .environmentObject(DIContainer(services: StubServices()))
}
