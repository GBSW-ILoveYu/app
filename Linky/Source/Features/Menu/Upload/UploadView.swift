        //
        //  UploadView.swift
        //  Linky
        //
        //  Created by 박성민 on 3/31/25.
        //

        import SwiftUI

        struct UploadView: View {
            @EnvironmentObject var pathModel : RootViewModel
            @StateObject var viewModel: UploadViewModel
            
            var body: some View {
                switch viewModel.phase {
                case .notRequested:
                    content
                case .loading:
                    UploadingView()
                case .success:
                    UploadOkVIew(viewModel: viewModel)
                case .fail:
                    UploadFailView()
                }
            }
            
            
            var content: some View {
                VStack{
                    Image("uploadImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 177)
                    Spacer()
                        .frame(height: 25)
                    Text("다음에 다시 찾아 볼 링크를 저장해둬요 !!")
                        .font(AppFonts.wantedSansBold(size: 14))
                        .foregroundStyle(.customGray)
                    Spacer()
                        .frame(height: 54)
                    UploadFormView(text: $viewModel.text)
                    
                    Spacer()
                        .frame(height: 19)
                    UploadCustomButton(
                        title: "링크 저장하기",
                        action: {
                            viewModel.send(action: .sendLink)
                        }
                    )
                }
            }
            
        }

        fileprivate struct UploadFormView: View {
            @Binding var text: String
            var body: some View{
                TextField("",text: $text)
                    .padding()
                    .font(AppFonts.wantedSansBold(size: 13))
                    .foregroundStyle(.customGray)
                    .frame(width: 352, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customBlue, lineWidth: 2)
                    )
            }
        }
        #Preview {
            UploadView(viewModel: UploadViewModel(container: DIContainer(services: StubServices())))
                .environmentObject(RootViewModel())
        }
