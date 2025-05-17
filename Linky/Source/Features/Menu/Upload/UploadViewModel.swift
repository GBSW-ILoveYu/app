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
                .sink { result in
                    switch result{
                    case .finished:
                        break
                    case .failure:
                        print("실패")
                        self.phase = .fail
                    }
                } receiveValue: { response in
                    print(response)
                    self.phase = .success
                }.store(in: &subscriber)
        case .resetPhase:
            self.phase = .notRequested
            self.text = ""
        }
    }
}
