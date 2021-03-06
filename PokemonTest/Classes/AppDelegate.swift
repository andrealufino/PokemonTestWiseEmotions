//
//  AppDelegate.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splitVC: UISplitViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            print("AppDelegate - iPhone")
            let pokemonListViewController = PokemonListViewController.init()
            window?.rootViewController = UINavigationController.init(rootViewController: pokemonListViewController)
            pokemonListViewController.view.backgroundColor = .yellow
            window?.makeKeyAndVisible()
        } else {
            print("AppDelegate - iPad")
            splitVC = UISplitViewController.init()
            let masterVC = PokemonListViewController.init()
            let detailVC = PokemonDetailsViewController.init()
            let masterNavVC = UINavigationController.init(rootViewController: masterVC)
            let detailNavVC = UINavigationController.init(rootViewController: detailVC)
            splitVC!.viewControllers = [masterNavVC, detailNavVC]
            masterVC.delegate = detailVC
            splitVC?.preferredDisplayMode = .allVisible
            window?.rootViewController = splitVC
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

