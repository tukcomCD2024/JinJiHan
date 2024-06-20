//
//  TypeReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

@Observable class TypeReportViewModel {
    
    var typeReportList: [TypeReport]?

    // 비율이 낮은 순으로 정렬 (파이 차트에서 반시계방향으로 그래프 차지)
    var sortedList: [TypeReport] {
        if let reportList = typeReportList {
            return reportList.sorted { ($0.views ?? 0) < ($1.views ?? 0) }
        } else {
            return []
        }
    }
    
    var typeCancellable: AnyCancellable?
    
    let provider = MoyaProvider<StatisticsService>(plugins: [MoyaLoggingPlugin()])
    
    func typeToViewModel(_ list: [TypeReport]) {
        self.typeReportList = list
    }
}

extension TypeReportViewModel {
    
    public func getTypeReport() {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = typeCancellable {
            cancellable.cancel()
        }
        
        typeCancellable = provider.requestWithProgressPublisher(
            .statisticsCategory(accessToken: accessToken)
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: [TypeReport].self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("type report 조회성공")
            case .failure(let error):
                Log.network("type report network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.typeToViewModel(response)
            print(response)
        })
    }
}
