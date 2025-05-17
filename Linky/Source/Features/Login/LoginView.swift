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
    @State private var alertType: LoginAlertType? = nil
    
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
                                alertType = .success
                            } else {
                                alertType = .error(viewModel.errorMessage ?? "에러")
                            }
                        }
                    },
                    singUpAction: {
                        viewModel.send(action: .goSignUp)
                    }
                )
            }
        }
        .alert(item: $alertType){ alert in
            switch alert{
            case .success:
                return Alert(
                    title: Text("로그인 성공"),
                    message: Text("로그인이 완료되었습니다."),
                    dismissButton: .default(Text("확인")){
                        viewModel.send(action: .goLogin)
                    }
                )
            case .error(let message):
                return Alert(
                    title: Text("로그인 실패"),
                    message: Text(message),
                    dismissButton: .default(Text("확인"))
                )
            }
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
    LoginView(viewModel: .init(container: .init(services: StubServices()), pathModel: RootViewModel()))
        .environmentObject(RootViewModel())
}
