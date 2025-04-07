//
//  SharedLinkModalViewModel.swift
//  Linky
//
//  Created by 박성민 on 4/7/25.
//

import Foundation

class SharedLinkModalViewModel: ObservableObject {
    @Published var sharedLinks: [String] = []
    @Published var showModal: Bool = false

    func loadSharedLinks() {
        if let links = UserDefaults(suiteName: "group.com.Linky.shared")?.stringArray(forKey: "sharedQueue"),
           !links.isEmpty {
            self.sharedLinks = links
            self.showModal = true
        }
    }

    func saveAllLinks() {
        print("저장된 링크들: \(sharedLinks)")

        UserDefaults(suiteName: "group.com.Linky.shared")?.removeObject(forKey: "sharedQueue")
        self.showModal = false
    }
}
