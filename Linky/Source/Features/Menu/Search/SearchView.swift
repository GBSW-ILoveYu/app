//
//  SearchView.swift
//  Linky
//
//  Created by 박성민 on 3/31/25.
//

import SwiftUI

struct SearchView: View {
    @State private var categories: [Category] = [
        Category(title: "전체", count: 32),
        Category(title: "IT", count: 6),
        Category(title: "식물", count: 3),
        Category(title: "음악", count: 4),
        Category(title: "요리", count: 1)
    ]
    var body: some View {
        CategoryListView(categories: categories)
    }
}

fileprivate struct CategoryListView: View {
    @EnvironmentObject var pathModel: PathModel
    let categories: [Category]
    
    var body: some View{
        VStack(spacing:15){
            HStack{
                Spacer()
                    .frame(width: 27)
                Text("링크 저장소")
                    .font(AppFonts.wantedSansBold(size: 18))
                Spacer()
            }
            ForEach(categories) { category in
                Button(action: {
                        pathModel.paths.append(.categoryDetail(category))
                }) {
                    SearchContainer(
                        number:"\(category.count)",
                        title: category.title
                    )
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(PathModel())
}
