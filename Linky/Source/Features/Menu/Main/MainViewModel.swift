//
//  MainViewModel.swift
//  Linky
//
//  Created by 박성민 on 5/18/25.
//

import Foundation
import Combine

class MainViewModel: ObservableObject{
    enum Action{
        case getLink
        case recentlyLink
    }
    
    @Published var categoryCounts: [String: Int] = [:]
    @Published var totalLinkCount: Int = 0
    @Published var recentlyLinks: [LinkResponse] = [
        LinkResponse(
            id: 1,
            url: "https://www.acmicpc.net/problem/1021",
            category: "교육 & 학습",
            title: "ㅁㄴㅇㅁㄴ어ㅏㅁ너이dwqjnldㄴ어ㅏㅁ너이dwqjnldㄴㅇ",
            description: "ㅁㄴ어ㅏㅁ너이dwqjnldkqwㄴ어ㅏㅁ너이dwqjnldnjldkqㅏㅁ니아",
            thumbnail: "https://onlinejudgeimages.s3-ap-northeast-1.amazonaws.com/images/boj-og.png",
            createdAt: "1223",
            updatedAt: "1234",
            user: linkUser(id: 1, nickName: "박성민", imageUri: nil)
        )
    ]
    
    private var categories = ["IT","경제","디자인","교육 & 학습","여가","뉴스","기타","음식","음악"]
    private var container: DIContainer
    private var subscriber = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action){
        switch action{
        case .getLink:
            container.services.linkService.getLink()
                .sink { completion in
                    switch completion{
                    case .finished:
                        break
                    case .failure:
                        print("erorr")
                    }
                } receiveValue: { [weak self] links in
                    print(links)
                    self?.calculateCategoryCounts(links)
                }.store(in: &subscriber)
        case .recentlyLink:
            container.services.linkService.recentlyOpened()
                .sink { completion in
                    switch completion{
                    case .finished:
                        break
                    case .failure:
                        print("error")
                    }
                } receiveValue: { [weak self] links in
                    self?.recentlyLinks = self?.urlFormatter(links: links) ?? []
                }.store(in: &subscriber)
        }
    }
    
    private func calculateCategoryCounts(_ links: [LinkResponse]){
        // categories를 바탕으로 초기값 설정 ["IT" : 0] 형식으로
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
    
    func urlFormatter(links: [LinkResponse]) -> [LinkResponse] {
        return links.map { link in
            var modifiedLink = link
            modifiedLink.url = "https://\(link.url)"
            return modifiedLink
        }
    }
}
