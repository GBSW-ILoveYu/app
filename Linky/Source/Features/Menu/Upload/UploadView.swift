//
//  UploadView.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct UploadView: View {
    @EnvironmentObject var pathModel : PathModel
    @State var text: String = ""
    
    var body: some View {
        VStack{
            Image("uploadImage")
                .resizable()
                .scaledToFit()
                .frame(width: 177)
            Spacer()
                .frame(height: 25)
            Text("다음에 다시 찾아 볼 링크를 저장해둬요 !!")
                .font(AppFonts.wantedSansBold(size: 14))
                .foregroundStyle(.customGray)
            Spacer()
                .frame(height: 54)
            UploadFormView(text: $text)
            
            Spacer()
                .frame(height: 19)
            UploadCustomButton(
                title: "링크 저장하기",
                action: {
                    pathModel.paths.append(.upload)
                }
            )
        }
    }
}

fileprivate struct UploadFormView: View {
    @Binding var text: String
    var body: some View{
        TextField("",text: $text)
            .padding()
            .font(AppFonts.wantedSansBold(size: 13))
            .foregroundStyle(.customGray)
            .frame(width: 352, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.customBlue, lineWidth: 2)
            )
    }
}
#Preview {
    UploadView()
        .environmentObject(PathModel())
}
