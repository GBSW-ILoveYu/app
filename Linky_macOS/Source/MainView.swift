//
//  MainView.swift
//  Linky_macOS
//
//  Created by 박성민 on 4/14/25.

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        switch viewModel.currentView{
        case .main:
            linkBody
        case .login:
            LoginView()
        case .signup:
            SignUpView()
        }
    }
    
    var linkBody: some View {
        VStack {
            
            HStack {
                Spacer()
                    .frame(width: 10)
                Image("link")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                
                Text("링크를 저장하세요")
                    .font(.custom("Pretendard-Bold", size: 16))
                    .foregroundStyle(.customGray)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 20)
            TextField("",text:$viewModel.sendUrl)
                .padding()
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 340,height: 42)
                .background(.customGray1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.customBlue, lineWidth: 2)
                )
            Spacer()
                .frame(height: 20)
            Button{
                viewModel.send(action: .addLink)
            }label: {
                Text("저장하기")
                    .frame(width: 121, height: 40)
                    .font(.custom("Pretendard-Bold", size: 15))
                    .foregroundStyle(.white)
                    .background(.customBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(width: 400,height: 228)
        .background(.white)
    }
}

#Preview {
    MainView()
        .environmentObject(AppViewModel())
}
