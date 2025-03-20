//
//  CustomTextField.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct CustomTextField: View {
    var title = "아이디를 입력하세요"
    @Binding var text: String
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt:Text(title)
                .font(AppFonts.wantedSansRegular(size: 12))
                .foregroundStyle(.customGray)
        )
            .padding(.leading,20)
            .frame(width: 300,height: 45)
            .font(AppFonts.wantedSansRegular(size: 12))
            .background(.white)
            .foregroundStyle(.customGray)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .border(Color.customGray, width: 1)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    CustomTextField(title: "아이디를 입력하세요", text: $text)
}
