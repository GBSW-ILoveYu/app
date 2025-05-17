//
//  UploadingView.swift
//  Linky
//
//  Created by 박성민 on 5/17/25.
//

import SwiftUI

struct UploadingView: View {
    var body: some View {
        ZStack{
            Color.customSkyBlue
            VStack{
                Image("sandClock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                    .frame(height: 37)
                
                Text("링크를 저장중입니다 · · · ")
                    .font(AppFonts.wantedSansBold(size: 16))
                
                Spacer()
                    .frame(height: 14)
            }
        }
    }
}

#Preview {
    UploadingView()
}
