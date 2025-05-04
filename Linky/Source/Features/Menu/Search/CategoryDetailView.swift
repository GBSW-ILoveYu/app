import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    @EnvironmentObject var pathModel: RootViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 1)
            
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
            .padding(.horizontal,20)
            .frame(width: 402, height: 50)
            .background(.customBlue)
            
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
            
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var category = Category(title: "전체", count: 6)
    CategoryDetailView(category: category)
        .environmentObject(RootViewModel())
}
