//
//  MainView.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var menuViewModel: MenuViewModel
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack{
            MainViewTitle(name: menuViewModel.user?.nickName ?? "없음")
            
            ProgressBar(currentValue: Double(viewModel.openCount), totalValue: Double(viewModel.totalLinkCount))
            
            Spacer()
                .frame(height: 30)
            
            LinkRepository()
            
            Spacer()
                .frame(height: 20)
            
            VisitLinkRepository()
            Spacer()
        }
        .onAppear{
            viewModel.send(action: .getLink)
            viewModel.send(action: .recentlyLink)
            viewModel.send(action: .countLink)
        }
        .environmentObject(viewModel)
    }
}

fileprivate struct MainViewTitle: View {
    @EnvironmentObject var viewModel : MainViewModel
    var name : String
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
                    Text("저장해둔 \(viewModel.openCount)개의 링크")
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
    var currentValue: Double
    var totalValue: Double
    
    var progress : Double {
        totalValue == 0 ? 0 : currentValue / totalValue
    }
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Text("\(Int(currentValue)) / \(Int(totalValue))")
                    .font(AppFonts.wantedSansBold(size: 12))
                Spacer()
                    .frame(width: 40)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 15)
                        .foregroundColor(.customGray1)
                        .cornerRadius(10)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * CGFloat(self.progress), height: 15)
                        .foregroundColor(.customBlue)
                        .cornerRadius(10)
                        .animation(.linear, value: progress)
                }
            }
            .frame(height: 15)
            .padding(.horizontal,30)
        }
    }
}

fileprivate struct LinkRepository: View {
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
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
                LazyHStack(spacing:20){
                    CustomLinkBox(number: "\(viewModel.totalLinkCount)", title: "전체")
                        .onTapGesture {
                            let category = Category(title: "전체", count: viewModel.totalLinkCount)
                            rootViewModel.send(action: .push(.categoryDetail(category)))
                        }
                    ForEach(viewModel.categoryCounts.sorted(by: {$0.value > $1.value}), id: \.key){ category, count in
                        if count > 0 {
                            CustomLinkBox(number: "\(count)", title: category)
                                .onTapGesture {
                                    let category = Category(title: category, count: count)
                                    rootViewModel.send(action: .push(.categoryDetail(category)))
                                }
                        }
                    }
                }
            }
            
            .padding()
        }
        .frame(width: 402,height: 209)
        .padding()
        .background(.customGray1)
    }
}

fileprivate struct VisitLinkRepository: View {
    @EnvironmentObject var viewModel: MainViewModel
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 30)
                Text("최근 열어 본 링크")
                    .font(AppFonts.wantedSansBold(size: 18))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(viewModel.recentlyLinks, id: \.id) { link in
                        Button(action: {
                            if let url = URL(string: link.url) {
                                openURL(url)
                            }
                        }) {
                            VStack(alignment: .leading, spacing: 6) {
                                AsyncImage(url: URL(string: link.thumbnail)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 180)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(link.title)
                                    .font(AppFonts.wantedSansMedium(size: 18))
                                    .foregroundStyle(.black)
                                    .lineLimit(1)
                                    .padding(.horizontal, 20)
                                Text(link.description)
                                    .font(AppFonts.wantedSansMedium(size: 11))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                    .padding(.horizontal, 20)
                            }
                            .frame(width: 150, height: 120)
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel(container: DIContainer(services: StubServices())))
        .environmentObject(MenuViewModel(container: .init(services: StubServices())))
        .environmentObject(RootViewModel())
}
