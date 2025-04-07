//
//  Category.swift
//  Linky
//
//  Created by 박성민 on 4/7/25.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let count: Int
}
