//
//  CustomHeader.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct CustomHeader: View {
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 20)
            Image("textLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60)
            Spacer()
        }
    }
}

#Preview {
    CustomHeader()
}
