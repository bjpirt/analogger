//
//  SceneDelegate.swift
//  Analogger
//
//  Created by Ben Pirt on 28/09/2024.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {

    let nc = NotificationCenter.default

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession, options
               connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = scene as? UIWindowScene else {return}
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground")
    }
}
