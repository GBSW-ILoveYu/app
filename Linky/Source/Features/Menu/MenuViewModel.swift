//
//  MenuViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import Foundation

class MenuViewModel: ObservableObject{
    static let shared = MenuViewModel() 
    @Published var searchText: String = ""
    @Published var selectedTab: Int = 0
    
    func changeSearchView(){
        print("asdasd")
        selectedTab = 2
    }
}
