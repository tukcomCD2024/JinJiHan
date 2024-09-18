
import SwiftUI
import Combine

struct RecentNewsCardView: View {
    let news: RecentNewsDatum
    @EnvironmentObject var pathModel: PathModel
//    @StateObject private var newsViewModel = RecentNewsViewModel()
    @StateObject private var debateRoomViewModel = CreateDebateRoomViewModel()
    @State private var topic: String = ""
    
       var body: some View {
           HStack {
               titleView
           }
           .clipShape(RoundedRectangle(cornerRadius: 8))
       }
       
    
    var titleView : some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Text("📌")
                    .font(.title)
                Text(news.title ?? "")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .frame(width: 240, height: 96)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 30)
                    .background(.gray01)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray05, lineWidth: 1.0)
                    }
                    .shadow(color: .basicBlack.opacity(0.1), radius: 2)
                Button {
                    print("버튼 클릭됨 - 주제: \(news.title)")
                    topic = news.title ?? ""
                    debateRoomViewModel.createDebate(topic: topic) { debateTopic in
                        pathModel.paths.append(.createdebateroom)
                        print("토론방 생성 완료 - 주제: \(debateTopic)")

                    }
//                    pathModel.paths.append(.createdebateroom)
                } label: {
                    Text("토론 시작하기")
                        .foregroundStyle(.basicWhite)
                        .font(.pretendardRegular14)
                        .padding(.horizontal, 38)
                        .padding(.vertical, 10)
                        .background(.primary01)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
            if let debateID = debateRoomViewModel.debateID {
                Text("토론방 ID: \(debateID)")
            }
            
            if let errorMessage = debateRoomViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 32)
        .background(.gray02)
    }
}


