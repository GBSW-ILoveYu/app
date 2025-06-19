//
//  LoginView.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/15/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : AppViewModel
    @State var id : String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("로그인")
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
            
            CustomTextField(title: "이메일", text: $viewModel.login.email)
            
            Spacer()
                .frame(height: 30)
            
            CustomTextField(title: "비밀번호", text: $viewModel.login.password)
            
            Spacer()
                .frame(height: 20)
            Text("아직 링키의 계정이 없으신가요?")
                .foregroundStyle(.gray)
                .font(.system(size: 11))
            Text("회원가입하기")
                .foregroundStyle(.customNavy)
                .font(.system(size: 11))
                .onTapGesture {
                    viewModel.currentView = .signup
                }
            Spacer()
                .frame(height: 20)
            Button{
                viewModel.send(action: .login)
            }label: {
                Text("로그인")
                    .frame(width: 121, height: 40)
                    .font(.custom("Pretendard-Bold", size: 15))
                    .foregroundStyle(.white)
                    .background(.customBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(width: 400,height: 380)
        .background(.white)
    }
}

#Preview {
    LoginView()
        .environmentObject(AppViewModel())
}
