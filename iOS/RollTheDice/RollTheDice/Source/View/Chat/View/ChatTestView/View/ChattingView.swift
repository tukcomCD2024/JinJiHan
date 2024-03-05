//
//  ChattingView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import Foundation
import SwiftUI

struct ChattingView: View {
    
    var body: some View {
        HStack {
            ChatTitleView()
            
            Spacer()
            
            ChatExampleView(title: "ChattingView")
        }
    }
    
    
}
