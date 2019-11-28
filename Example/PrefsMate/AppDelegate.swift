//
//  AppDelegate.swift
//  PrefsMate
//
//  Created by 蔡越 on 09/26/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PrefsViewController(with: Bundle.main.url(forResource: "Prefs", withExtension: "plist")!))
        window?.makeKeyAndVisible()
        return true
    }
    
}

