//
//  AppDelegate.swift
//  OrderKing
//
//  Created by Artem Tischenko on 08.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit
import KDCalendar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = { UIWindow(frame: UIScreen.main.bounds) }()
   
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if SettingsService.instance.token == "" {
            NavigationService.initialize(modules: ["Login"], setRootHandler: setRoot, mode: .normal)
        } else {
            NavigationService.initialize(modules: ["Expenses", "Calendar", "Profile"],
                                         setRootHandler: setRoot,
                                         mode: .tab)
        }
        DialogService.initialize(getTopViewController: getTopViewController)
        DataServices.initialize(isMock: true,
                                baseUrl: Consts.instance.baseUrl,
                                getToken: self.getToken,
                                unauthorized: self.unautorized)
        ImagePickService.initialize(getTopViewController: getTopViewController)
        setupStatusBar()
        setupCalendarView()
        setupTabBar()
        setupNavigationBar()
        window?.backgroundColor = .white
        return true
    }
    
    func setupStatusBar() {
        if #available(iOS 13.0, *) {
               let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
               let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
               statusBar.backgroundColor = Styles.Colors.mainColor
               window?.addSubview(statusBar)
        } else {
               UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    func setupCalendarView() {
        let style = CalendarView.Style()
        style.cellColorToday = Styles.Colors.mainColor
        style.cellTextColorToday = .white
        style.cellSelectedBorderWidth = 1.0
        style.cellSelectedBorderColor  = Styles.Colors.mainColor
        style.weekdaysBackgroundColor = Styles.Colors.mainColor
        style.weekdaysTextColor = .white
        style.headerBackgroundColor = Styles.Colors.mainColor
        style.headerTextColor = .white
        style.cellColorDefault = .white
        style.cellTextColorDefault = Styles.Colors.mainColor
        style.cellBorderWidth = 1.0
        style.cellBorderColor = Styles.Colors.mainColor
        CalendarView.Style.Default = style
    }
    
    func setupTabBar() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = Styles.Colors.mainColor
    }
    
    func setupNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barStyle = .black
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearace.barTintColor = Styles.Colors.mainColor
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.shadowImage =  UIImage()
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
    
    func getToken() -> String {
        SettingsService.instance.token
    }
    
    func unautorized() {
        SettingsService.instance.token = ""
        let dic = ["modules": ["Login"],
                   "mode": NavigationService.NavigationMode.root,
                   "navigationParams": [:] as [String: Any]] as [String: Any]
        SwiftEventBus.postToMainThread(Consts.instance.navigationToMessage, sender: dic)
    }
    func setRoot(viewController: UIViewController) {
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }
}
