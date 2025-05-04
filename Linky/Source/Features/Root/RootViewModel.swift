//
//  RootViewModel.swift
//  Linky
//
//  Created by 박성민 on 4/30/25.
//

import Foundation

class RootViewModel: ObservableObject {
    
    enum Action{
        case push(PathType)
        case pop
        case reset
    }
    
    @Published var paths: [PathType] = []
    
    func send(action: Action) {
        switch action {
        case .push(let path):
            paths.append(path)
        case .pop:
            paths.removeLast()
        case .reset:
            paths = []
        }
    }
}
