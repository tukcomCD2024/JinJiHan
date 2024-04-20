//
//  Image.swift
//  RollTheDice
//
//  Created by Subeen on 4/20/24.
//

import SwiftUI

// Async Image는 resizable() 프로퍼티를 제공하지 않음
// Image에 수정할 수 있도록 extension 정의 

extension Image {
    func ImageModifier() -> some View {
        self
        
            .resizable()
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .scaledToFill()
            .frame(width: 320, height: 160)
            
    }
    
//    func IconModifier() -> some View {
//        self
//            .ImageModifier()
//            .frame(maxWidth: 200)
//            .foregroundColor(.blue.opacity(0.6))
//    }
}
