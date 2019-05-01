//
//  AppDelegate.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/25/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // TODO: Create APIClient and call Terminal.setTokenProvider here.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = RootViewController();
        self.window?.makeKeyAndVisible()

        return true
    }

}
