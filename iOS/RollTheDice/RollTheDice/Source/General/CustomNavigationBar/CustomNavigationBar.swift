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
        leadingItems: [(Image, () -> Void)] = [],
        trailingItems: [(Image, () -> Void)] = []
    ) {
        self.title = title
        self.isDisplayLeadingBtn = isDisplayLeadingBtn
        self.isDisplayTrailingBtn = isDisplayTrailingBtn
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }
    
    var body: some View {
        HStack(spacing: 20) {
            if isDisplayLeadingBtn {
                ForEach(leadingItems.indices) { index in
                    Button(
                        action: {
                            leadingItems[index].1()
                        },
                        label: {
                            leadingItems[index].0
                                .foregroundStyle(.basicWhite)
                        }
                    )
                    
                }
            }
            
            Spacer()
            
            Text(title)
                .foregroundStyle(.basicWhite)
                .font(.pretendardRegular20)
            
            Spacer()
            
            HStack(spacing: 20) {
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
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "타이틀", isDisplayLeadingBtn: true, isDisplayTrailingBtn: true, leadingItems: [(Image(.chevronLeft), {print("hi")}) , (Image(.chevronLeft), {print("hi")})], trailingItems: [(Image(.chevronLeft), {print("hi")}) , (Image(.chevronLeft), {print("hi")})])
            .previewLayout(.sizeThatFits)
    }
}
