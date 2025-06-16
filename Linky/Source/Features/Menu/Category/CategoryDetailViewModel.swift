//
//  CategoryDetailViewModel.swift
//  Linky
//
//  Created by 박성민 on 5/19/25.
//

import Foundation
import Combine

class CategoryDetailViewModel: ObservableObject {
    enum Action {
        case detailgetLink
        case getLink(id: Int)
    }
    
    @Published var categoryTitle: String = ""
    @Published var links: [LinkResponse] = []
    
    private var container: DIContainer
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action){
        switch action {
        case .detailgetLink:
            container.services.linkService.detailgetLink(categoryTitle: categoryTitle)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] value in
                    self?.links = self?.urlFormatter(links: value) ?? []
                    print(value)
                }.store(in: &subscriber)
        case .getLink(let id):
            container.services.linkService.detailGetLink(id: id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { value in
                    print(value)
                }.store(in: &subscriber)
        }
    }
    
    func urlFormatter(links: [LinkResponse]) -> [LinkResponse] {
        return links.map { link in
            var modifiedLink = link
            modifiedLink.url = "https://\(link.url)"
            return modifiedLink
        }
    }
}
