//
//  CustomLinkBox.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct CustomLinkBox: View {
    var number: String = "32"
    var title: String = "전체"
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: 130,height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment:.leading){
                Text(number)
                    .font(AppFonts.wantedSansMedium(size: 12))
                    .foregroundStyle(.black)
                Text(title)
                    .font(AppFonts.wantedSansBold(size: 20))
                    .foregroundStyle(.customBlue)
            }
            .padding([.top,.trailing],50)
            
        }
    }
}

#Preview {
    CustomLinkBox()
}
