//
//  UploadCustomButton.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct UploadCustomButton: View {
    var title: String
    let action: () -> Void
    var backgroundColor: Color = .customBlue
    var body: some View {
        Button(action: action){
            Text(title)
                .frame(width: 352 , height: 49)
                .font(AppFonts.wantedSansBold(size: 16))
                .foregroundStyle(.white)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    UploadCustomButton(
        title: "로그인",
        action: {}
    )
}
