//
//  CustomErrorTextField.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct CustomErrorTextField: View {
    var title = "아이디를 입력하세요"
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group{
            if isSecure {
                SecureField(
                    "",
                    text: $text,
                    prompt:Text(title)
                        .font(AppFonts.wantedSansRegular(size: 12))
                        .foregroundStyle(.customRed)
                )
            } else {
                TextField(
                    "",
                    text: $text,
                    prompt:Text(title)
                        .font(AppFonts.wantedSansRegular(size: 12))
                        .foregroundStyle(.customRed)
                )
            }
        }
        .padding(.leading,20)
        .frame(width: 300,height: 45)
        .font(AppFonts.wantedSansRegular(size: 12))
        .background(.white)
        .foregroundStyle(.customRed)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .border(.customRed, width: 1)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    CustomErrorTextField(title: "비밀번호를 입력하세요", text: $text)
}
