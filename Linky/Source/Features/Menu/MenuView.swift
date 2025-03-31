//
//  MainView.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    var body: some View {
        VStack{
            CustomHeader()
            
            if viewModel.selectedTab == 0 || viewModel.selectedTab == 2{
                CustomSearchField(
                    text: $viewModel.searchText,
                    tabSearchView: viewModel.changeSearchView
                )
            }
            
            TabView(selection: $viewModel.selectedTab) {
                MainView()
                    .tabItem {
                        Image("home")
                            .resizable()
                            .frame(width: 30,height:30)
                    }
                    .tag(0)
                UploadView()
                    .tabItem {
                        Image("plus")
                            .resizable()
                            .frame(width: 30,height:30)
                    }
                    .tag(1)
                SearchView()
                    .tabItem{
                        Image("imageLogo")
                            .resizable()
                            .frame(width: 30,height:30)
                    }
                    .tag(2)
            }
            .tint(.customBlue)
        }
    }
}

#Preview {
    MenuView()
}
