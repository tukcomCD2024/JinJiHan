//
//  DetailCardNews.swift
//  RollTheDice
//
//  Created by 신예진 on 4/16/24.
//

import Foundation
import SwiftUI

struct DetailCardNews: View {
    
    var body: some View {
        ZStack{
            Color.basicBlack.ignoresSafeArea(.all)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.basicWhite)
                    .frame(width: 970, height: 495)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 170, leading: 112, bottom: 170, trailing: 112))
                
                HStack(spacing: 30) {
                    Image("CardSample")
                        .resizable()
                        .frame(width: 370, height: 495)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                        .clipped()
                        .padding(.leading,-58)
                       
                    
                    VStack{
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 534, height: 1)
                          .background(.black)
                          .padding(.bottom, 24)
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 492, height: 52)
                          .overlay(
                            Rectangle()
                              .inset(by: 0.5)
                              .stroke(.gray06, lineWidth: 1)
                          )
                        
                        HStack(alignment: .top){
                            
                            Text("기사 제목 보여주기")
                              .font(
                                Font.custom("Pretendard", size: 32)
                                  .weight(.bold)
                              )
                              .foregroundColor(.basicBlack)
                              .frame(width: 318, alignment: .topLeading)
                              .padding(.leading, -140)
                              .padding(.top, -53)
                            
                        }
                        
                        
                        Text("(서울=연합뉴스) 오규진 기자 = 삼성전자는 플래그십 스마트폰 갤럭시 S24 시리즈에 500㎖ 플라스틱 물병 약 5천만 개와 맞먹는 수준으로 재활용 플라스틱을 활용하고 있다고 16일 밝혔다.삼성전자 뉴스룸에 따르면 회사는 오는 22일 지구의 날을 맞아 갤럭시 S24 시리즈에 사용될 재활용 플라스틱이 올해에만 약 100t에 이를 것으로 예상했다.이는 500㎖ 페트병 약 1천만 개를 만드는 데 사용되는 플라스틱 무게와 동일하다.삼성전자는 폐어망과 폐페트병 등을 갤럭시 스마트폰에 사용할 수 있는 고성능 플라스틱 소재로 개발해 사용하고 있다.특히 갤럭시 S24 시리즈에는 신발 제조 공정 중 발생한 열가소성 폴리우레탄(TPU) 부산물을 재활용한 플라스틱 소재가 새롭게 적용됐다.재활용 알루미늄 소재도 같은 기간 330㎖ 알루미늄 음료 캔 약 900만 개에 해당하는 약 110t이 활용될 것으로 회사는 전망했다.제품 패키지 박스도 100％ 재활용 종이 소재를 활용하고 있는데, 올해 말까지 A4 용지 약 5억5천200만 장의 무게와 동일한 약 2천760t이 활용될 것으로 예측됐다.이 종이를 쌓으면 아랍에미리트(UAE) 두바이에 있는 세계에서 가장 높은 건축물인 '부르즈 할리파'를 71개 만든 것과 동일하다고 삼성전자는 소개했다.갤럭시 S24 시리즈는 갤럭시 제품 중 처음으로 재활용 코발트, 희토류 등 재활용 광물을 주요 부품에 적용하기도 했다.")
                          .font(
                            Font.custom("Pretendard", size: 15)
                                .weight(.regular)
                          )
                          .foregroundColor(.basicBlack)
                          .frame(width: 500, alignment: .topLeading)
                          .padding(.top, 30)

                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 534, height: 1)
                          .background(.black)
                          .padding(.top, 24)
                          .padding(.bottom, 10)
                        
                    }
                    
                    
                    
                 
                
                }
                
            }
            
            
        }
        
        
    }
}

#Preview {
    DetailCardNews()
    
}
