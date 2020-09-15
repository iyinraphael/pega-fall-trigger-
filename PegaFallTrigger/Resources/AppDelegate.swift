//
//  AppDelegate.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/14/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navVC = UINavigationController()
        let vc = MainViewController()
        navVC.addChild(vc)
        navVC.view.frame = vc.view.bounds
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController  = navVC
        
        window?.makeKey()
        window?.makeKeyAndVisible()
        
        return true
    }


}

