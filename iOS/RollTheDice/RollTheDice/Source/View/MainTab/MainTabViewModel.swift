//
//  MainTabViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import Foundation

class MainTabViewModel: ObservableObject {
    @Published var selectedTabItem: Int = 0
    @Published var selectedTabIndex: Int = .zero
    @Published var selectedTabType: MainTabType = .newsList
}
