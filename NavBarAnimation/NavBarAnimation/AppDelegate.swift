//
//  AppDelegate.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = ViewControllerA()
        let navigationController = UINavigationController(rootViewController: vc)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}

