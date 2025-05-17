//
//  MenuViewModel.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import Foundation
import SwiftUI
import Combine

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
    enum Action {
        case load
    }
    
    @Published var searchText: String = ""
    @Published var selectedTab: TabType = .main
    @Published var phase: Phase = .notRequested
    @Published var user: User? = nil
    
    private var container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer){
        self.container = container
    }
    
    func send(action: Action){
        switch action{
        case .load:
            loadUser()
        }
    }
    
    func changeSearchView(){
        selectedTab = .search
    }
    
    func loadUser() {
        phase = .loading
        container.services.userService.getUser()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    break
                case .failure:
                    self?.phase = .fail
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.phase = .success
            }
            .store(in: &cancellables)
    }
}
