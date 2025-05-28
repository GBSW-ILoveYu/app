//
//  UploadViewModel.swift
//  Linky
//
//  Created by 박성민 on 5/15/25.
//

import Foundation
import Combine

class UploadViewModel : ObservableObject{
    enum Action {
        case sendLink
        case resetPhase
    }
    
    @Published var text: String = ""
    @Published var phase: Phase = .notRequested
    @Published var category: String = ""
    @Published var errorMessage: String? = nil
    
    private var container : DIContainer
    private var subscriber = Set<AnyCancellable>()
    init(container: DIContainer){
        self.container = container
    }
    
    func send(action: Action){
        switch action{
        case .sendLink:
            self.phase = .loading
            container.services.linkService.sendLink(url: text)
                .sink { [weak self] result in
                    switch result{
                    case .finished:
                        break
                    case .failure(let error):
                        switch error{
                        case .urlError(let message):
                            self?.errorMessage = message.values.joined(separator: "\n")
                        default:
                            self?.errorMessage = "알수 없는 오류가 발생했습니다."
                        }
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] response in
                    self?.category = response
                    self?.phase = .success
                }.store(in: &subscriber)
            
        case .resetPhase:
            self.phase = .notRequested
            self.text = ""
            self.category = ""
            self.errorMessage = nil
        }
    }
}
