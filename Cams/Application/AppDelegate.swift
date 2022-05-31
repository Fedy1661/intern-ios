//
//  AppDelegate.swift
//  Cams
//
//  Created by Fedor Konovalov on 22.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = .init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.becomeFirstResponder()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let k = storyboard.instantiateViewController(withIdentifier: "main.screen")
        
        window?.rootViewController = k
        
        let cameraShortcut = UIMutableApplicationShortcutItem(
            type: "open.cameras",
            localizedTitle: "Камеры",
            localizedSubtitle: nil,
            icon: UIApplicationShortcutIcon(systemImageName: "camera"),
            userInfo: ["TabIndex": 2 as NSSecureCoding]
        )
        
        let doorShortcut = UIMutableApplicationShortcutItem(
            type: "open.doors",
            localizedTitle: "Двери",
            localizedSubtitle: nil,
            icon: UIApplicationShortcutIcon(systemImageName: "house"),
            userInfo: ["TabIndex": 2 as NSSecureCoding]
        )
        
        application.shortcutItems = [cameraShortcut, doorShortcut]
        
        return true
    }

}
