//
//  MainView.swift
//  Linky
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel : MenuViewModel
    var body: some View {
        VStack{
            CustomHeader()
            
            if viewModel.selectedTab == .main || viewModel.selectedTab == .search {
                CustomSearchField(
                    text: $viewModel.searchText,
                    tabSearchView: viewModel.changeSearchView
                )
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            TabView(selection: $viewModel.selectedTab) {
                ForEach(TabType.allCases, id: \.self) { tab in
                    tabContent(for: tab)
                        .tabItem{
                            Image(tab.icon)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .tag(tab)
                }
            }
            .animation(.easeInOut, value: viewModel.selectedTab)
            .tint(.customBlue)
            
//          SharedLinkModalView()
        }
    }
    
    @ViewBuilder
    func tabContent(for tab: TabType) -> some View {
        switch tab {
        case .main:
            MainView()
        case .upload:
            UploadView()
        case .search:
            SearchView()
        }
    }
}

#Preview {
    MenuView(viewModel: .init())
        .environmentObject(RootViewModel())
}
