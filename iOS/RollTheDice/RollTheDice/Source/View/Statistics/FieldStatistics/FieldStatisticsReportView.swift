//
//  FieldStatisticsReportView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//

import SwiftUI

struct FieldStatisticsListView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 1000, height: 500)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            VStack {
                
                Image("graph1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500, height: 500)
                
                HStack{
                    Text("텍스트 예시")
                        .font(.title)
                        .foregroundColor(.black)
                    
                }
                
            }
            .padding()
            
            Spacer()
            
            
            
            
            
            
        }
    }
}

struct FieldStatisticsListView_Previews: PreviewProvider {
    static var previews: some View {
        FieldStatisticsListView()
    }
}
