//
//  UploadOkVIew.swift
//  Linky
//
//  Created by 박성민 on 4/4/25.
//

import SwiftUI

struct UploadOkVIew: View {
    var category : String = "음악"
    @EnvironmentObject var pathModel : RootViewModel
    var body: some View {
        ZStack{
            Color.customSkyBlue
                .ignoresSafeArea()
            VStack{
                Image("link")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                    .frame(height: 37)
                
                Text("링크 저장이 완료되었습니다.")
                    .font(AppFonts.wantedSansBold(size: 20))
                
                Spacer()
                    .frame(height: 14)
                
                Text("카테고리: \(category)")
                    .foregroundStyle(.customBlue)
                    .font(AppFonts.wantedSansBold(size: 15))
                
                Spacer()
                    .frame(height: 65)
                
                UploadCustomButton(
                    title: "홈으로",
                    action: {
                        pathModel.send(action: .push(.main))
                    }
                )
                
            }
        }
    }
}

#Preview {
    UploadOkVIew()
        .environmentObject(RootViewModel())
}
