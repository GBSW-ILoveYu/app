import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    @EnvironmentObject var pathModel: RootViewModel
    @StateObject var viewModel: CategoryDetailViewModel
    var body: some View {
        VStack {
            Spacer().frame(height: 1)
            header
            infoHeader
            ScrollView{
                LazyVStack(alignment:.leading,spacing: 20){
                    ForEach(viewModel.links, id: \.id){ link in
                        VStack(alignment: .leading, spacing: 6) {
                            AsyncImage(url: URL(string: link.thumbnail)){ image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 350)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(link.title)
                                .font(AppFonts.wantedSansMedium(size: 12))
                            
                            Text(link.description)
                                .font(AppFonts.wantedSansMedium(size: 11))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.horizontal,20)
            }
            Spacer()
        }
        .onAppear{
            viewModel.categoryTitle = category.title
            viewModel.send(action: .detailgetLink)
        }
    }
    private var header: some View {
        HStack {
            Button {
                pathModel.send(action: .pop)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.customWhite)
            }
            
            Spacer()
            
            Text(category.title)
                .font(AppFonts.wantedSansBold(size: 18))
                .foregroundStyle(.customWhite)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
        .background(.customBlue)
    }
    
    private var infoHeader: some View {
        HStack {
            Image("fire")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            Text("\(category.count)개의 링크가 저장되어있습니다")
                .font(AppFonts.wantedSansBold(size: 12))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var category = Category(title: "전체", count: 6)
    CategoryDetailView(category: category, viewModel: CategoryDetailViewModel(container: .init(services: StubServices())))
        .environmentObject(RootViewModel())
}
