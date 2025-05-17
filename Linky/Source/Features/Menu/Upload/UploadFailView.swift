//
//  UploadFailView.swift
//  Linky
//
//  Created by 박성민 on 5/17/25.
//

import SwiftUI

struct UploadFailView: View {
    var body: some View {
        ZStack{
            Color.customSkyBlue
            VStack{
                Image("FailImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                    .frame(height: 37)
                
                Text("링크 저장을 실패하였습니다.")
                    .font(AppFonts.wantedSansBold(size: 20))
                
                Spacer()
                    .frame(height: 14)
                
                Text("다시 시도해주세요!")
                    .foregroundStyle(.customBlue)
                    .font(AppFonts.wantedSansBold(size: 15))
                
                Spacer()
                    .frame(height: 34)
                
                UploadCustomButton(
                    title: "다시 저장하기",
                    action: { print("다시 저장") },
                    backgroundColor: .customYellow
                )
                
                Spacer()
                    .frame(height: 15)
                
                UploadCustomButton(
                    title: "홈으로",
                    action: { print("홈") }
                )
            }
        }
    }
}

#Preview {
    UploadFailView()
}
