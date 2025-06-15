//
//  SignUpView.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/15/25.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var id : String = ""
    @State var password: String = ""
    @State var passwordCheck: String = ""
    @State var email: String = ""
    
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
            
            CustomTextField(title: "이름", text: $name)
                        
            CustomTextField(title: "아이디", text: $id)
            
            CustomTextField(title: "비밀번호", text: $password)
            
            CustomTextField(title: "비밀번호확인", text: $passwordCheck)
            
            CustomTextField(title: "이메일", text: $email)
            Spacer()
                .frame(height: 30)
            
            Button{
                
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
}
