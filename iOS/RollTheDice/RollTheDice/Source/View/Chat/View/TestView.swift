//
//  TestView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/9/24.
//

import SwiftUI

struct TestView: View {
    
    @State private var chatMessages: [String] = []
    @State private var userInput: String = ""
    @State private var selectedTitle: String?
    
    var body: some View {
        VStack {
            // 왼쪽에는 제목 목록 표시
            List {
                ForEach(0..<10) { index in
                    Button(action: {
                        selectedTitle = "Title \(index)"
                    }) {
                        Text("Title \(index)")
                            .padding()
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 100)
            
        }
    }
    
}

#Preview {
    TestView()
}
