//
//  CustomNavigationBar.swift
//  voiceMemo
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool
    let isDisplayRightBtn: Bool
    
    let leftBtnAction: () -> Void        // 액션을 받아와서 전달해줌
    let rightBtnAction: () -> Void
    
//    let rightBtnType: NavigationBtnType
    
    init(
        isDisplayLeftBtn: Bool = true,
        isDisplayRightBtn: Bool = false,
        leftBtnAction: @escaping () -> Void = {},
        rightBtnAction: @escaping () -> Void = {}
//        rightBtnType: NavigationBtnType = .edit
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
//        self.rightBtnType = rightBtnType
    }
    
  var body: some View {
        HStack {
            if isDisplayLeftBtn {
                Button {
                    leftBtnAction()                    // 전달 받은 액션을 버튼에 대딥
                } label: {
                    Text("<")
                        .foregroundStyle(.basicWhite)
//                    Image("leftArrow")
                }
                
            }
            
            Spacer()
            
//            Text("d")
            
            Spacer()
            
            if isDisplayRightBtn {
                Button {
                 rightBtnAction()
                } label: {
//                    if rightBtnType == .close {
//                        Image("close")
//                    } else {
//                        Text(rightBtnType.rawValue)
//                            .foregroundColor(.customBlack)
//                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 40)
  }

}

struct CustomNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavigationBar()
  }
}
