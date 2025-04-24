//
//  ContentView.swift
//  Linky_macOS
//
//  Created by 박성민 on 4/14/25.

import SwiftUI

struct macosApp: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                    .frame(width: 10)
                Image("link")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                // 폰트 왜안되냐 진짜 짜증난다 ㅋㅋㅋㅋㅋ
                Text("링크를 저장하세요")
                    .font(.custom("Pretendard-Bold", size: 15))
                    .foregroundStyle(.customGray)
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            TextField("",text:$text)
                .padding()
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 459,height: 42)
                .background(.customGray1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.customBlue, lineWidth: 2)
                )
            Spacer()
                .frame(height: 20)
            Button{
                
            }label: {
                Text("저장하기")
                    .frame(width: 151, height: 42)
                    .font(.custom("Pretendard-Bold", size: 15))
                    .foregroundStyle(.white)
                    .background(.customBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(width: 512,height: 228)
        .background(.white)
    }
}

#Preview {
    macosApp()
}
