//
//  CustomNavigationBar.swift
//  DittoCommunity
//
//  Created by Subeen on 2023/11/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    
    let isDisplayLeadingBtn: Bool
    let isDisplayTrailingBtn: Bool
    
    let leadingItems: [(Image, () -> Void)]
    let trailingItems: [(Image, () -> Void)]
    
    init(
        title: String = "",
        isDisplayLeadingBtn: Bool = true,
        isDisplayTrailingBtn: Bool = true,
        leadingItems: [(Image, () -> Void)] = [(Image("chevron.left"), {})],
        trailingItems: [(Image, () -> Void)] = [(Image("chevron.left"), {})]
    ) {
        self.title = title
        self.isDisplayLeadingBtn = isDisplayLeadingBtn
        self.isDisplayTrailingBtn = isDisplayTrailingBtn
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if isDisplayLeadingBtn {
//                ForEach(leadingItems, id:\.self) { item in
//                    Button(
//                        action: {
//                            item.1()
//                        },
//                        label: {
//                            leadingItems[index].0
//                                .foregroundStyle(.basicWhite)
//                        }
//                    )
//                }
            }
            
            Spacer()
            
            Text(title)
                .foregroundStyle(.basicWhite)
            
            Spacer()
            
            if isDisplayTrailingBtn {
                ForEach(trailingItems.indices) { index in
                    Button(
                        action: {
                            trailingItems[index].1()
                        },
                        label: {
                            trailingItems[index].0
                                .foregroundStyle(.basicWhite)
                        }
                    )
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 44)
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
            .previewLayout(.sizeThatFits)
    }
}
