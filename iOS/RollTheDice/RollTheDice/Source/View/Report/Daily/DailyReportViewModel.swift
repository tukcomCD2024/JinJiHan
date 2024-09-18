//
//  DailyReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

@Observable class DailyReportViewModel {
    var dailyReportList: DailyReport?
    
    /// 일주일 평균 조회수 
    var averageView: String {
        var aver = 0.0
        
        if let list = dailyReportList?.data {
            for daily in list {
                aver += Double(daily.views ?? 0)
            }
        }
        
        
        return String(format: "%.1f", aver / 7)
    }
    
    var dailyCancellable: AnyCancellable?
    
    let provider = MoyaProvider<StatisticsService>(plugins: [MoyaLoggingPlugin()])
    
    func dailyToViewModel(_ list: DailyReport) {
        self.dailyReportList = list
    }
}

extension DailyReportViewModel {
    
    public func getDailyViews() {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = dailyCancellable {
            cancellable.cancel()
        }
        
        dailyCancellable = provider.requestWithProgressPublisher(
            .recentSevenPerDate(accessToken: accessToken)
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: DailyReport.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("daily report 조회성공")
            case .failure(let error):
                Log.network("daily report network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.dailyToViewModel(response)
            print(response)
        })
    }
}
