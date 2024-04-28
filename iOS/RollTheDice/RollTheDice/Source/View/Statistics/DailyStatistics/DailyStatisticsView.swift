//
//  DailyStatisticsView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//

import Foundation
import SwiftUI

struct DailyStatisticsView: View {
    
    var body: some View {
        ZStack{
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            ScrollView(.horizontal){
                
                HStack{
                    
                    VStack{
                        Image("graph2")
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("뉴스관람빈도")
                            .bold()
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                        .frame(width: 100)
                    
                }
                
            }
            
        }
    }
    
}

#Preview {
    DailyStatisticsView()
}
