//
//  SceneDelegate.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation
import KakaoSDKAuth
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
