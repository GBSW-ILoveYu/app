//
//  SharedLinkModalView.swift
//  Linky
//
//  Created by 박성민 on 4/7/25.
//

import SwiftUI



struct SharedLinkModalView: View {
    @StateObject private var viewModel = SharedLinkModalViewModel()
    
    var body: some View {
        EmptyView()
            .onAppear {
                viewModel.loadSharedLinks()
            }
            .sheet(isPresented: $viewModel.showModal) {
                VStack(spacing: 20) {
                    Text("최근 공유한 링크 (\(viewModel.sharedLinks.count))개")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.sharedLinks, id: \.self) { link in
                                Text(link)
                                    .font(.system(size: 14))
                                    .lineLimit(1)
                                    .lineSpacing(1)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    HStack {
                        Button(action: {
                            viewModel.showModal = false
                        }) {
                            Text("취소")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.saveAllLinks()
                        }) {
                            Text("저장하기")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
    }
}

#Preview {
    SharedLinkModalView()
}
