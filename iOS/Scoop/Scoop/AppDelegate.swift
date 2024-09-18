//
//  AppDelegate.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

final class AppDelegate: UIResponder, UIApplicationDelegate {

    private var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }

}
