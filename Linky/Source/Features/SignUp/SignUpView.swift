//
//  SignUpView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var pathModel : RootViewModel
    @StateObject var viewModel : SignUpViewModel
    @State private var alertType: SignUpAlertType? = nil
    
    var body: some View {
        ZStack{
            Color.customSkyBlue
                .ignoresSafeArea()
            
            VStack{
                Image("textLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88)
                Text("회원가입")
                    .font(AppFonts.wantedSansBold(size: 24))
                    .foregroundStyle(.customBlue)
                Spacer()
                    .frame(height: 59)
                
                SignUpFormView(
                    name: $viewModel.name,
                    id: $viewModel.id,
                    password: $viewModel.password,
                    passwordCheck: $viewModel.passwordCheck,
                    email: $viewModel.email,
                    errorBox: $viewModel.errorBox,
                    onSignUp: {
                        viewModel.signUp { success in
                            if success {
                                alertType = .success
                            } else {
                                alertType = .error(viewModel.errorMessage ?? "에러")
                            }
                        }
                    }
                )
            }
        }
        .alert(item: $alertType){ alert in
            switch alert {
            case .error(let message):
                return Alert(
                    title: Text("회원가입 에러"),
                    message: Text(message),
                    dismissButton: .default(Text("확인"))
                )
            case .success:
                return Alert(
                    title: Text("회원가입 성공"),
                    message: Text("회원가입이 완료되었습니다"),
                    dismissButton: .default(Text("확인")) {
                        pathModel.send(action: .push(.main))
                    }
                )
            }
        }
    }
}

fileprivate struct SignUpFormView: View {
    @Binding var name: String
    @Binding var id: String
    @Binding var password: String
    @Binding var passwordCheck: String
    @Binding var email: String
    @Binding var errorBox: Set<SignUpField>
    var onSignUp: () -> Void
    
    var body: some View{
        VStack(spacing:16) {
            Group{
                if errorBox.contains(.name) {
                    CustomErrorTextField(
                        title: "이름을 입력하세요.",
                        text: $name
                    )
                } else {
                    CustomTextField(
                        title: "이름을 입력하세요.",
                        text: $name
                    )
                }
            }
            
            Group {
                if errorBox.contains(.id) {
                    CustomErrorTextField(
                        title: "아이디를 입력하세요.",
                        text: $id
                    )
                } else {
                    CustomTextField(
                        title: "아이디를 입력하세요.",
                        text: $id
                    )
                }
            }
            
            Group {
                if errorBox.contains(.password) {
                    CustomErrorTextField(
                        title: "비밀번호를 입력하세요.",
                        text: $password,
                        isSecure: true
                    )
                } else {
                    CustomTextField(
                        title: "비밀번호를 입력하세요.",
                        text: $password,
                        isSecure: true
                    )
                }
            }
            Group {
                if errorBox.contains(.passwordCheck) {
                    CustomErrorTextField(
                        title: "비밀번호 확인을 입력하세요.",
                        text: $passwordCheck,
                        isSecure: true
                    )
                } else {
                    CustomTextField(
                        title: "비밀번호 확인을 입력하세요.",
                        text: $passwordCheck,
                        isSecure: true
                    )
                }
            }
            
            Group {
                if errorBox.contains(.email) {
                    CustomErrorTextField(
                        title: "이메일을 입력하세요.",
                        text: $email
                    )
                } else {
                    CustomTextField(
                        title: "이메일을 입력하세요.",
                        text: $email
                    )
                }
            }
        }
        
        CustomButton(
            title: "회원가입",
            backgroundColor: .customBlue,
            foregroundColor: .white,
            action: onSignUp
        )
        .padding(.top, 10)
    }
}


#Preview {
    SignUpView(viewModel: .init(container: .init(services: StubServices())))
        .environmentObject(RootViewModel())
}
