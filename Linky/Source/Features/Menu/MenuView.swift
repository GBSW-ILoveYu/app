//
//  MainView.swift
//  Linky
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel : MenuViewModel
    @EnvironmentObject var container: DIContainer
    var body: some View {
        switch viewModel.phase{
        case .notRequested:
            PlaceholderView()
                .onAppear{
                    viewModel.send(action: .load)
                }
        case .loading:
            LoadingView()
        case .success:
            content
                .environmentObject(viewModel)
        case .fail:
            ErrorView()
        }
    }
    
    var content: some View {
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
        }
    }
    
    @ViewBuilder
    func tabContent(for tab: TabType) -> some View {
        switch tab {
        case .main:
            MainView(viewModel: .init(container: container))
        case .upload:
            UploadView(viewModel: .init(container: container))
        case .search:
            SearchView(viewModel: .init(container: container))
        }
    }
    
}

#Preview {
    MenuView(viewModel: .init(container: DIContainer(services: StubServices())))
        .environmentObject(RootViewModel())
        .environmentObject(DIContainer(services: StubServices()))
    
}
