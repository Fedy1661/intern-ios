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
        
        let k = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "main.screen")
        
        window?.rootViewController = k
        
        return true
    }

}

