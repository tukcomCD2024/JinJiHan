//
//  SplashView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("primary01")
                        .ignoresSafeArea(.all)
            VStack {
                Spacer()
                
                
                Text("수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n수빈아스푼날아오게해줘수빈아스푼날아오게해줘\n")
                                .bold()
                                .font(.system(size: 50))
                            
                            Image("Spoon")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding()
                                .offset(x: 10)
                
                Spacer()
                    .frame(height: 100)
            }
        }
    }
}



#Preview {
    SplashView()
}
