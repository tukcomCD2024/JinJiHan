//
//  FieldStatisticsView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//


import SwiftUI

struct FieldStatisticsView: View {
    
    var body: some View {
        ZStack{
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            ScrollView(.horizontal){
                
                HStack{
                    
                    VStack{
                        Image("graph1")
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("유저관심사반영")
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
    FieldStatisticsView()
}
