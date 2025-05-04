//
//  LoginView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel : LoginViewModel
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var pathModel: RootViewModel
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack{
            Color.customSkyBlue
                .ignoresSafeArea()
            
            VStack{
                Image("textLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88)
                Text("로그인")
                    .font(AppFonts.wantedSansBold(size: 24))
                    .foregroundStyle(.customBlue)
                
                Spacer()
                    .frame(height: 34)
                
                LoginFormView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    loginAction: {
                        viewModel.login { success in
                            if success {
                                pathModel.send(action: .push(.main))
                            } else {
                                showAlert.toggle()
                            }
                        }
                    },
                    singUpAction: {
                        pathModel.send(action: .push(.signUp))
                    }
                )
            }
        }
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("로그인 실패"),
                message: Text(viewModel.errorMessage ?? "실패"),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

fileprivate struct LoginFormView: View {
    @Binding var email: String
    @Binding var password: String
    
    var loginAction: () -> Void
    var singUpAction: () -> Void
    
    var body: some View{
        VStack{
            CustomTextField(
                title: "이메일을 입력하세요",
                text: $email
            )
            
            Spacer()
                .frame(height: 14)
            
            CustomTextField(
                title: "비밀번호를 입력하세요",
                text: $password,
                isSecure: true
            )
            
            Spacer()
                .frame(height: 34)
            
            CustomButton(
                title: "로그인",
                backgroundColor: .customBlue,
                foregroundColor: .white,
                action: loginAction
            )
            
            Spacer()
                .frame(height: 8)
            
            CustomButton(
                title: "회원가입",
                backgroundColor: .white,
                foregroundColor: .customBlue,
                action: singUpAction
            )
        }
    }
}

#Preview {
    LoginView(viewModel: .init(container: .init(services: StubServices())))
        .environmentObject(RootViewModel())
}
