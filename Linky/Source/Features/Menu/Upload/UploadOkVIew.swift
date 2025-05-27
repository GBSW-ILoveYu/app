//
//  UploadOkVIew.swift
//  Linky
//
//  Created by 박성민 on 4/4/25.
//

import SwiftUI

struct UploadOkVIew: View {
    var category : String
    @EnvironmentObject var menuViewModel : MenuViewModel
    @EnvironmentObject var viewModel : UploadViewModel
    var body: some View {
        ZStack{
            Color.customSkyBlue
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
                        menuViewModel.selectedTab = .main
                        viewModel.send(action: .resetPhase)
                    }
                )
            }
        }
    }
}

#Preview {
    UploadOkVIew(category:"기타")
        .environmentObject(RootViewModel())
        .environmentObject(UploadViewModel(container: .init(services: StubServices())))
}
