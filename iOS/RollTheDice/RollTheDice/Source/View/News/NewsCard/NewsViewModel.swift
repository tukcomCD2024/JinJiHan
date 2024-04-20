//
//  NewsCardViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import Foundation

public class NewsViewModel: ObservableObject {
    @Published var news: News
    
    init(news: News) {
        self.news = news
    }
}
