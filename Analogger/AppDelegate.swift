//
//  AppDelegate.swift
//  Analogger
//
//  Created by Ben Pirt on 28/09/2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    private let actions: AnaloggerActions = .shared
    private let watchComms = WatchComms()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.initWatchComms()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        let sceneConfig : UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func initWatchComms(){
        watchComms.setMessageHandler(type: "getData", callback: {
            let currentFilmRoll = self.actions.getActiveFilmRoll()
            if currentFilmRoll == nil {
                return ["shotCount": 0 , "rollName": "Not found"]
            }
            return ["shotCount": currentFilmRoll!.filmShots?.count ?? 0 , "rollName": currentFilmRoll!.name]
        })

        watchComms.setMessageHandler(type: "logShot", callback: {
            let currentFilmRoll = self.actions.getActiveFilmRoll()
            if currentFilmRoll == nil {
                return ["shotCount": 0 , "rollName": "Not found"]
            }
            _ = self.actions.logShot(filmRoll: currentFilmRoll!)
            return ["shotCount": currentFilmRoll!.filmShots?.count ?? 0 , "rollName": currentFilmRoll!.name]
        })
    }
}
