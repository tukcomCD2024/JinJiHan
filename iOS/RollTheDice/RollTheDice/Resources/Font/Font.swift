//
//  Font.swift
//  RollTheDice
//
//  Created by Subeen on 3/14/24.
//

import SwiftUI

extension Font {
    
    // Bold
    static let pretendardBold40: Font = .custom("Pretendard-Bold", size: 40)
    static let pretendardBold32: Font = .custom("Pretendard-Bold", size: 32)
    static let pretendardBold24: Font = .custom("Pretendard-Bold", size: 24)
    static let pretendardBold14: Font = .custom("Pretendard-Bold", size: 14)
    static let pretendardBold12: Font = .custom("Pretendard-Bold", size: 12)
    
    // Regular
    static let pretendardRegular20: Font = .custom("Pretendard-Regular", size: 20)
    static let pretendardRegular14: Font = .custom("Pretendard-Regular", size: 14)
    
}


/// 폰트가 추가되었는지 확인
func checkFontFile() {
    for fontFamily in UIFont.familyNames {
        for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
            print(fontName)
        }
    }
}

