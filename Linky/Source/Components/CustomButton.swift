//
//  CustomButton.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor : Color
    var foregroundColor : Color
    let action: () -> Void
    var body: some View {
        Button(action: action){
            Text(title)
                .frame(width: 300, height: 45)
                .font(AppFonts.wantedSansBold(size: 16))
                .foregroundStyle(foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .border(.customBlue,width: 1)
                .background(backgroundColor)
        }
    }
}

#Preview {
    CustomButton(
        title: "로그인",
        backgroundColor: .customBlue,
        foregroundColor: .white,
        action: {}
    )
}
