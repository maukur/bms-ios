//
//  AppDelegate.swift
//  OrderKing
//
//  Created by Artem Tischenko on 08.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = { UIWindow(frame: UIScreen.main.bounds) }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if SettingsService.instance.token == "" {
            NavigationService.initialize(modules: ["Login"], setRootHandler: setRoot, mode: .normal)
        }
        else {
            NavigationService.initialize(modules: ["Expenses", "Calendar", "Profile"], setRootHandler: setRoot, mode: .tab)
        }
        DialogService.initialize(getTopViewController:getTopViewController)
        DataServices.initialize(isMock: false, baseUrl: Consts.instance.baseUrl, getToken: self.getToken, unauthorized: self.unautorized)
        ImagePickService.initialize(getTopViewController:getTopViewController)
        
        setupTabBar()
        return true
    }
    func setupTabBar(){
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = Styles.colors.mainColor

    }
    func getTopViewController() -> UIViewController? {
         if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func getToken() -> String{
        SettingsService.instance.token
    }
    
    func unautorized() {
        SettingsService.instance.token = ""
        let dic = ["modules": ["Login"],  "mode": NavigationService.navigationMode.root, "navigationParams": [:] as Dictionary<String, Any>] as [String : Any]
        SwiftEventBus.postToMainThread(Consts.instance.NavigationToMessage, sender: dic)
    }
    
    func setRoot(viewController:UIViewController){
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }
    
    
}

