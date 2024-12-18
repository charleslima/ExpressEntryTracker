//
//  AppDelegate.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = DrawsViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
