////
////  NewsCardViewModel.swift
////  RollTheDice
////
////  Created by Subeen on 2/9/24.
////
//
import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

@Observable class NewsViewModel: ObservableObject {
    
    var newsDetail: News?
    
    var newsCancellable: AnyCancellable?
    
    let provider = MoyaProvider<NewsService>(plugins: [MoyaLoggingPlugin()])
    
    func newsToViewModel(_ model: News) {
        self.newsDetail = model
    }
    
    
}

extension NewsViewModel {
    public func getNewsDetail(newsId: Int) {
        let accessToken = ""
        
        if let cancellable = newsCancellable {
            cancellable.cancel()
        }
        
        newsCancellable =
        provider.requestWithProgressPublisher(
            .newsDetail(
                newsId: newsId,
                accessToken: accessToken
            )
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: News.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
                // success
            case .finished:
                print("newsDetail 조회 성공")
                break
            case .failure(let error):
//                print(error.localizedDescription)
                Log.network("network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.newsToViewModel(response)
            print(response)
            // 여기서 status 분기 처리
        })
    }
}
