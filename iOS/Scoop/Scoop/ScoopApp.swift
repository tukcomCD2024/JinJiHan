//
//  ScoopApp.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct ScoopApp: App {
    
    @StateObject var container: DIContainer = .init(services: Services())
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "ff09b3d83873ed4e320f0d6bc90759d6")
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: AuthenticationViewModel(container: container))
                .environmentObject(container)
        }
    }
}
