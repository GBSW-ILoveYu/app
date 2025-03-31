//
//  MainView.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            MainViewTitle()
            
            ProgressBar()
            
            LinkRepository()
            
            Spacer()
                .frame(height: 20)
            VisitLinkRepository()
            Spacer()
        }
    }
}

fileprivate struct MainViewTitle: View {
    var name : String = "박성민"
    var count : Int = 18
    var body: some View{
        HStack{
            Spacer()
                .frame(width: 40)
            VStack(alignment:.leading){
                HStack{
                    Text(name)
                        .font(AppFonts.wantedSansBold(size: 20))
                    Text("님")
                        .font(AppFonts.wantedSansMedium(size: 18))
                        .padding(.leading,-5)
                }
                HStack{
                    Text("저장해둔 \(count)개의 링크")
                        .font(AppFonts.wantedSansBold(size: 20))
                        .foregroundStyle(.customBlue)
                    Text("를")
                        .padding(.leading,-8)
                        .font(AppFonts.wantedSansMedium(size: 20))
                }
                HStack{
                    Text("잊지않고 열어보셨네요!")
                        .font(AppFonts.wantedSansMedium(size: 18))
                }
            }
            Spacer()
            Image("link")
                .resizable()
                .scaledToFit()
                .frame(width: 79)
            Spacer()
                .frame(width: 40)
        }
    }
}

fileprivate struct ProgressBar: View {
    var body: some View{
        VStack{
            Text("progressBar")
            //MARK: - 이건 나중에 구현해야지 ㅎㅎ
        }
    }
}

fileprivate struct LinkRepository: View {
    
    var body: some View{
        VStack{
            Spacer()
                .frame(height: 15)
            HStack{
                Spacer()
                    .frame(width:20)
                Text("링크 저장소")
                    .font(AppFonts.wantedSansBold(size: 18))
                Spacer()
            }
            Spacer()
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing:20){
                    CustomLinkBox()
                    CustomLinkBox()
                    CustomLinkBox()
                    CustomLinkBox()
                    CustomLinkBox()
                    
                }
            }
            .padding()
        }
        .frame(width: .infinity,height: 209)
        .padding()
        .background(.customGray1)
    }
}

fileprivate struct VisitLinkRepository: View {
    var body: some View{
        VStack{
            HStack{
                Spacer()
                    .frame(width: 30)
                Text("최근 열어 본 링크")
                    .font(AppFonts.wantedSansBold(size: 18))
                Spacer()
            }
            //MARK: - 최근 열어본 링크 페이지 구현
        }
    }
}
#Preview {
    MainView()
}
