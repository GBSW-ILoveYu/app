//
//  MenuViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import Foundation
import SwiftUI

enum TabType : Hashable , CaseIterable {
    case main
    case upload
    case search
    var icon: String {
        switch self{
        case .main: return "home"
        case .upload: return "plus"
        case .search: return "imageLogo"
        }
    }
}
                            
class MenuViewModel: ObservableObject{
    @Published var searchText: String = ""
    @Published var selectedTab: TabType = .main
    
    func changeSearchView(){
        selectedTab = .search
    }
    
}
