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
    }
    
    @Published var categoryTitle: String = ""
    @Published var links: [LinkResponse] = []
//    @Published var stublinks: [LinkResponse] = [
//        LinkResponse(
//            id: 1,
//            url: "https://www.example.com/swiftui",
//            category: "IT",
//            title: "SwiftUI 튜토리얼",
//            description: "SwiftUI를 사용한 UI 구성 방법",
//            thumbnail: "https://static.wanted.co.kr/images/meta/meta_home_default.jpeg",
//            createdAt: "2025-05-19T12:00:00Z",
//            updatedAt: "2025-05-19T12:00:00Z",
//            user: linkUser(id: 1, nickName: "사용자1", imageUri: nil)
//        ),
//        LinkResponse(
//            id: 2,
//            url: "https://www.example.com/economy",
//            category: "경제",
//            title: "경제 뉴스 업데이트",
//            description: "최신 경제 동향과 분석",
//            thumbnail: "https://static.wanted.co.kr/images/meta/meta_home_default.jpeg",
//            createdAt: "2025-05-19T13:00:00Z",
//            updatedAt: "2025-05-19T13:00:00Z",
//            user: linkUser(id: 2, nickName: "사용자2", imageUri: nil)
//        )
//    ]
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
                } receiveValue: { [weak self]value in
                    self?.links = value
                }.store(in: &subscriber)
            
        }
    }
}
