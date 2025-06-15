//
//  LoginView.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/15/25.
//

import SwiftUI

struct LoginView: View {
    @State var id : String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
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
            
            CustomTextField(title: "아이디", text: $id)
            
            Spacer()
                .frame(height: 30)
            
            CustomTextField(title: "비밀번호", text: $password)
            Spacer()
                .frame(height: 40)
            
            Button{
                
            }label: {
                Text("로그인")
                    .frame(width: 151, height: 42)
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
}
