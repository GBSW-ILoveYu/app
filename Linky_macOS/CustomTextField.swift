//
//  CustomTextField.swift
//  Linky_macOS
//
//  Created by 박성민 on 6/15/25.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(.customGray)
            
            Spacer()
        }
        .padding(.horizontal,20)
        TextField("",text: $text)
            .padding()
            .textFieldStyle(PlainTextFieldStyle())
            .frame(width: 330,height: 50)
            .background(.customGray1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.customBlue, lineWidth: 2)
            )
    }
}

#Preview {
    @Previewable @State var text: String = ""
    CustomTextField(title:"아이디", text: $text)
}
