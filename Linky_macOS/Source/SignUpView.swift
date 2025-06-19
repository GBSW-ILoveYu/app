//
//  SignUpView.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/15/25.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("회원가입")
                    .font(.custom("Pretendard-Bold", size: 20))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:73,height: 32)
                    .foregroundStyle(.customBlue)
                
            }
            .padding(.horizontal,10)
            Spacer()
                .frame(height: 20)
            CustomTextField(title: "이름", text: $viewModel.signUp.name)
            Spacer()
                .frame(height: 10)
            CustomTextField(title: "아이디", text: $viewModel.signUp.id)
            Spacer()
                .frame(height: 10)
            CustomTextField(title: "비밀번호", text: $viewModel.signUp.password)
            Spacer()
                .frame(height: 10)
            CustomTextField(title: "비밀번호확인", text: $viewModel.signUp.passwordCheck)
            Spacer()
                .frame(height: 10)
            CustomTextField(title: "이메일", text: $viewModel.signUp.email)
            
            Spacer()
                .frame(height: 10)
            
            Text("링키의 계정이 있으신가요?")
                .foregroundStyle(.gray)
                .font(.system(size: 11))
            Text("회원가입하기")
                .foregroundStyle(.customNavy)
                .font(.system(size: 11))
                .onTapGesture {
                    viewModel.currentView = .login
                }
            
            Spacer()
                .frame(height: 10)
            
            Button{
                viewModel.send(action: .signup)
            }label: {
                Text("회원가입")
                    .frame(width: 151, height: 42)
                    .font(.custom("Pretendard-Bold", size: 15))
                    .foregroundStyle(.white)
                    .background(.customBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(width: 400,height: 600)
        .background(.white)
        
    }
}

#Preview {
    SignUpView()
        .environmentObject(AppViewModel())
}
