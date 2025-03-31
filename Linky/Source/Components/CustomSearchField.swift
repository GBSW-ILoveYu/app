//
//  CustomSearchField.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct CustomSearchField: View {
    @Binding var text: String
    var tabSearchView : () -> Void

    var body: some View {
        ZStack{
            TextField("검색어를 입력하세요.",text: $text)
                .padding()
                .padding(.leading, 40)
                .background(.customGray1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onChange(of: text){
                    tabSearchView()
                }
            HStack{
                Spacer()
                    .frame(width: 30)
                Image("search")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    CustomSearchField(
        text: $text,
        tabSearchView: { print("asdf") }
    )
}
