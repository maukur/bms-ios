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
        
        NavigationService.initialize(module: "Login", setRootHandler: setRoot)
        DialogService.initialize(getTopViewController:getTopViewController)
        DataServices.initialize(isMock: false, baseUrl: Consts.instance.baseUrl)
        ImagePickService.initialize(getTopViewController:getTopViewController)
        return true
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
    
    func setRoot(viewController:UIViewController){
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }
    
    
}

