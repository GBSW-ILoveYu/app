//
//  SearchView.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    var body: some View {
        CategoryListView(categories: viewModel.categoryCounts)
            .onAppear{
                viewModel.send(action: .getLink)
            }
    }
}

fileprivate struct CategoryListView: View {
    @EnvironmentObject var pathModel: RootViewModel
    let categories: [String:Int]
    
    var body: some View{
        VStack(spacing:15){
            
            HStack{
                Spacer()
                    .frame(width: 27)
                Text("링크 저장소")
                    .font(AppFonts.wantedSansBold(size: 18))
                Spacer()
            }
            ScrollView{
                ForEach(categories.sorted(by: { $0.key < $1.key }), id: \.key) { categorys, count in
                    if count > 0{
                        Button(action: {
                            let category = Category(title: categorys, count: count)
                            pathModel.send(action: .push(.categoryDetail(category)))
                        }) {
                            SearchContainer(
                                number:"\(count)",
                                title: categorys
                            )
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(container: .init(services: StubServices())))
        .environmentObject(RootViewModel())
}
