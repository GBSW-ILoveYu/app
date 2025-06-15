//
//  SearchViewModel.swift
//  Linky
//
//  Created by 박성민 on 5/28/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject{
    enum Action {
        case getLink
    }
    
    @Published var categoryCounts: [String: Int] = [:]
    @Published var totalLinkCount: Int = 0
    
    private var categories = ["전체","IT","경제","디자인","교육 & 학습","여가","뉴스","기타","음식","음악"]
    private var container: DIContainer
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action){
        switch action{
        case .getLink:
            container.services.linkService.getLink()
                .sink { complete in
                    switch complete{
                    case .finished:
                        break
                    case .failure(let error):
                        print("실패")
                    }
                } receiveValue: { [weak self] links in
                    print(links)
                    self?.calculateCategoryCounts(links)
                }.store(in: &subscriber)
        }
    }
    
    private func calculateCategoryCounts(_ links: [LinkResponse]){
        var counts: [String : Int] = Dictionary(uniqueKeysWithValues: categories.map { ( $0,0 ) })
        
        for link in links {
            let category = link.category
            if counts[category] != nil {
                counts[category]! += 1
            } else {
                counts["기타"] = (counts["기타"] ?? 0) + 1
            }
        }
        self.categoryCounts = counts
        self.totalLinkCount = links.count
    }
}
