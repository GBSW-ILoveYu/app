//
//  SearchContainer.swift
//  Linky
//
//  Created by 박성민 on 4/5/25.
//

import SwiftUI

struct SearchContainer: View {
    var number : String = "6"
    var title : String = "IT"
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 350,height: 57)
                .foregroundStyle(.customGray1)
                .cornerRadius(10)
            HStack{
                Spacer()
                    .frame(width: 50)
                VStack(alignment: .leading){
                    Text(number)
                        .font(AppFonts.wantedSansMedium(size: 12))
                        .foregroundStyle(.customGray)
                    Text(title)
                        .font(AppFonts.wantedSansBold(size: 16))
                        .foregroundStyle(.customBlue)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SearchContainer()
}
