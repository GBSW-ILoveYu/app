//
//  SignUpView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var pathModel : PathModel
    @StateObject var viewModel = SignUpViewModel()
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
                        if viewModel.signUp() {
                            pathModel.paths.append(.main)
                        } else {
                            showAlert.toggle()
                        }
                    }
                )
            }
        }
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("회원가입 에러"),
                message: Text(viewModel.errorMessage ?? "에러"),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

fileprivate struct SignUpFormView: View {
    @Binding var name: String
    @Binding var id: String
    @Binding var password: String
    @Binding var passwordCheck: String
    @Binding var email: String
    @Binding var errorBox: Int
    var onSignUp: () -> Void
    
    var body: some View{
        VStack(spacing:16) {
            CustomTextField(
                title: "이름을 입력하세요.",
                text: $name
            )
            
            CustomTextField(
                title: "아이디를 입력하세요.",
                text: $id
            )
            
            CustomTextField(
                title: "비밀번호를 입력하세요.",
                text: $password,
                isSecure: true
            )
            
            if errorBox == 4{
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
            
            CustomTextField(
                title: "이메일을 입력하세요.",
                text: $email
            )
            
            CustomButton(
                title: "회원가입",
                backgroundColor: .customBlue,
                foregroundColor: .white,
                action: onSignUp
            )
            .padding(.top, 10)
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(PathModel())
}
