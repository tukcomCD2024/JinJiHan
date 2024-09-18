//
//  NewsListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

// Macro -> iOS 17.0 이상부터. @Published 안 해도 됨.
// 사용할 때 var 형식으로 해도 됨.
@Observable class NewsListViewModel {
    var newsList: NewsList?
//    var selectedNewsId: Int?
    var currentPage = 0
    var newsCancellable: AnyCancellable?
    
    
    //TODO: Plugin Settings
    let provider = MoyaProvider<NewsService>(plugins: [MoyaLoggingPlugin()])
    
    func newsToViewModel(_ list: NewsList) {
        self.newsList = list
    }
}

extension NewsListViewModel {
    public func getAllNewsData(page: Int, size: Int) {
      
//        let accessToken = ""
        // TokenManager에서 accessToken 가져오기
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = newsCancellable {
            cancellable.cancel()
        }
        
        newsCancellable =
        provider.requestWithProgressPublisher(
            .news(
                page: page,
                size: size,
                accessToken: accessToken
            )
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: NewsList.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
                // success
            case .finished:
                print("news 조회 성공")
                break
            case .failure(let error):
                Log.network("network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.newsToViewModel(response)
            print(response)
            // 여기서 status 분기 처리
        })
    }
}
