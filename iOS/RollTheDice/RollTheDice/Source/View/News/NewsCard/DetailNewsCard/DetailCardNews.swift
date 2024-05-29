//
//  DetailCardNews.swift
//  RollTheDice
//
//  Created by 신예진 on 4/16/24.
//

import Foundation
import SwiftUI

struct DetailCardNews: View {
    @EnvironmentObject var pathModel: PathModel
    
    var newsViewModel = DetailNewsViewModel()
    var newsId: Int
    
    var body: some View {
        ZStack{
            Color.basicBlack.ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.basicWhite)
                        .cornerRadius(20)
                    
                    HStack(spacing: 0) {
                        
                        AsyncImage(url: URL(string: newsViewModel.newsDetail?.thumbnailUrl ?? "https://imgnews.pstatic.net/image/018/2024/05/15/0005739785_001_20240515190608817.jpg?type=w647")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 300)
                                    .cornerRadius(15)
                                    .clipped()
                                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.4), radius: 4)
                            case .empty:
                                Image(systemName: "photo.circle.fill")
                            
                            case .failure(_):
                                Image(systemName: "photo.circle.fill")
                            @unknown default:
                                Text("");
                            }
                            
                        }
                        
//                        Image("CardSample")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(maxWidth: 300)
//                            .cornerRadius(15)
//                            .clipped()
//                        
                        
                        VStack(alignment: .center) {
                            
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(height: 1)
                            
                            Text(newsViewModel.newsDetail?.title ?? "기사 제목 불러오는 중 ~")
                                .font(.pretendardBold32)
                                .foregroundColor(.basicBlack)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .background(Rectangle().stroke(Color.gray06, lineWidth: 1))
                            
                            HStack {
                                Spacer()
                                Text("발행일자 : \(newsViewModel.newsDetail?.postDate ?? "2024-01-01")")
                                    .font(.pretendardRegular14)
                                    .foregroundStyle(.gray05)
                                
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            
                            ScrollView {
                                Text(newsViewModel.newsDetail?.content ?? "요약 불러오는 중 ~")
                                    .font(
                                        .pretendardRegular16
                                    )
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.gray06)
                                    .frame(alignment: .topLeading)
                                    .padding(.top, 10)
                                    .padding(.horizontal, 20)
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    pathModel.paths.append(.webView(url: newsViewModel.newsDetail?.url ?? "https://n.news.naver.com/mnews/article/014/0005185580"))
                                } label: {
                                    Text("원문 보러 가기  ➡️")
                                        .font(.pretendardBold12)
                                        .foregroundStyle(.gray01)
                                        .padding(10)
                                        .background(.primary01)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                                .padding(.trailing, 10)
                                .padding(.bottom, 10)
                            }
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 1)
                                .background(.black)
                            
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                    }
                    
                }
                .padding(.vertical, 120)
                .padding(.horizontal, 110)
                
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            newsViewModel.getNewsDetail(newsId: self.newsId)
        }
    }
}

#Preview {
    DetailCardNews(newsId: 260)
    
}
