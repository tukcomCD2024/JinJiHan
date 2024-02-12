//
//  ChatExampleView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import SwiftUI
import ExyteChat

struct ChatExampleView: View {

    @StateObject private var viewModel: ChatExampleViewModel
    
    private let title: String

    init(viewModel: ChatExampleViewModel = ChatExampleViewModel(), title: String) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.title = title
    }
    
    var body: some View {
        
        ChatView(messages: viewModel.messages) { draft in
            viewModel.send(draft: draft)
        }
        .enableLoadMore(offset: 3) { message in
            viewModel.loadMoreMessage(before: message)
        }
        .messageUseMarkdown(messageUseMarkdown: true)
        .chatNavigation(
            title: viewModel.chatTitle,
            status: viewModel.chatStatus,
            cover: viewModel.chatCover
        )
        .mediaPickerTheme(
            main: .init(
                text: .pink,
                albumSelectionBackground: .black,
                fullscreenPhotoBackground: .basicBlack
            ),
            selection: .init(
                emptyTint: .white,
                emptyBackground: .black.opacity(0.25),
                selectedTint: .basicBlack,
                fullscreenTint: .white
            )
        )
        .onAppear(perform: viewModel.onStart)
        .onDisappear(perform: viewModel.onStop)
    }
}


#Preview {
    ChatExampleView(viewModel: .init(), title: "")
}
