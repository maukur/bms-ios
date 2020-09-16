//
//  NavigationService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 08.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

typealias SetRootHandlerAlias = (UIViewController) -> Void

class NavigationService {

    public enum NavigationMode {
        case normal
        case navigation
        case tab
        case root
        case modal
        case modalNavigation
    }
    private static let instance = NavigationService()
    private init() {}
    static private var setRoot: SetRootHandlerAlias?
    static func initialize(modules: [String],
                           setRootHandler:@escaping SetRootHandlerAlias,
                           mode: NavigationMode) {
        setRoot = setRootHandler
        switch mode {
        case .tab:
            navigateTabTo(modules: modules, navigationParams: [:])
        case .normal:
            let viewController = NavigationService.getModule(moduleName: modules[0], navigationParams: [:])
            setRoot?(viewController)
        default:
            break
        }
        SwiftEventBus.onMainThread(self, name: Consts.instance.navigationToMessage) { result in
            NavigationService.navigationTo(result: result?.object)
        }
        SwiftEventBus.onMainThread(self, name: Consts.instance.navigationBackMessage) { result in
            NavigationService.navigationBack(result: result?.object)
        }
    }
    private static func navigationTo(result: Any?) {
        let dic = result as! [String: Any]
        let mode = dic["mode"] as! NavigationMode
        let modules = dic["modules"] as! [String]
        let navigationParams = dic["navigationParams"] as! [String: Any]
        switch mode {
        case .normal:
            navigateNormalTo(module: modules.first!, navigationParams: navigationParams)
        case .navigation:
            navigateNavigationTo(module: modules.first!, navigationParams: navigationParams)
        case .tab:
             navigateTabTo(modules: modules, navigationParams: navigationParams)
        case .root:
            navigateRootTo(module: modules.first!, navigationParams: navigationParams)
        case .modal:
            navigateModalTo(module: modules.first!, navigationParams: navigationParams)
        case .modalNavigation:
            navigateModalNavigationTo(module: modules.first!, navigationParams: navigationParams)
        }
    }
    private static func navigateNormalTo(module: String, navigationParams: [String: Any]) {
        let viewController = getModule(moduleName: module, navigationParams: navigationParams)
        let tabNavigationController =
            NavigationService.instance.topTabBarController?.selectedViewController as! UINavigationController
        tabNavigationController.pushViewController(viewController, animated: true)
        NavigationService.instance.topNavigationController?.pushViewController(viewController, animated: true)
    }
    private static func navigateNavigationTo(module: String, navigationParams: [String: Any]) {
        let viewController = getModule(moduleName: module, navigationParams: navigationParams)
        let navigationController = UINavigationController(rootViewController: viewController)
        setRoot?(navigationController)
    }
    private static func navigateTabTo(modules: [String], navigationParams: [String: Any]) {
        var controllers: [UIViewController] = []
        let tabBarController = UITabBarController()
        modules.forEach({ (name) in
            let module = getModule(moduleName: name, navigationParams: navigationParams)
            let nsvigationcontroller = UINavigationController(rootViewController: module)
            controllers.append(nsvigationcontroller)
        })
        tabBarController.viewControllers = controllers
             for i in 0...(modules.count-1) {
                let title = Dictionaries.instance.tabBarSettings[modules[i]]!.0
                let image = Dictionaries.instance.tabBarSettings[modules[i]]!.1
                tabBarController.tabBar.items?[i].image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                tabBarController.tabBar.items?[i].title = title
        }

        setRoot?(tabBarController)
    }
    private static func navigateRootTo(module: String, navigationParams: [String: Any]) {
        let viewController = getModule(moduleName: module, navigationParams: navigationParams)
        setRoot?(viewController)
    }
    private static func navigateModalTo(module: String, navigationParams: [String: Any]) {
        let viewController = getModule(moduleName: module, navigationParams: navigationParams)
        NavigationService.instance.anyTopController?.present(viewController, animated: true)
    }
    private static func navigateModalNavigationTo(module: String, navigationParams: [String: Any]) {
        let viewController = getModule(moduleName: module, navigationParams: navigationParams)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        NavigationService.instance.anyTopController?.present(navigationViewController, animated: true)
    }
    private static func navigationBack(result: Any?) {
        let dic = result as! [String: Any]
        let mode = dic["mode"] as! NavigationMode
        switch mode {
        case .normal:
            navigateNormalBack()
        case .modal:
            navigateModalBack()
        default:
            return
        }
    }
    private static func navigateNormalBack() {
        let tabNavigationController =
            NavigationService.instance.topTabBarController?.selectedViewController as! UINavigationController
        tabNavigationController.popViewController(animated: true)
        NavigationService.instance.topNavigationController?.popViewController(animated: true)
    }
    private static func navigateModalBack() {
        let tabNavigationController =
            NavigationService.instance.topTabBarController?.selectedViewController as! UINavigationController
        tabNavigationController.dismiss(animated: true)
        NavigationService.instance.anyTopController?.dismiss(animated: true)
    }
    private static func getModule(moduleName: String, navigationParams: [String: Any]) -> UIViewController {
        let vcName = moduleName + "ViewController"
        let vmName = moduleName + "ViewModel"
        let storyboardName = moduleName + "Storyboard"
        let vcType = NavigationService.stringClassFromString(vcName) as! BaseViewController.Type
        let vmType = NavigationService.stringClassFromString(vmName) as! BaseViewModel.Type
        let vm = vmType.init()
        vm.navigationParams = navigationParams
        let bundle = Bundle(for: vcType)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let initialViewController = storyboard.instantiateInitialViewController()
        let viewController = initialViewController as! BaseViewController
        viewController.setViewModel(viewModel: vm)
        return viewController
    }
    private var rootController: UIViewController? {
        let app = UIApplication.shared
        let topWindow = app.windows.first { $0.isKeyWindow }
        let rootVC = topWindow?.rootViewController
        return rootVC
    }
    private var topViewController: UIViewController? {
        let split = topSplitController
        let navigation = topNavigationController
        let tabBar = topTabBarController
        if split != nil || navigation != nil || tabBar != nil {
            return nil
        }
        return rootController
    }
    private  var anyTopController: UIViewController? {
        rootController
    }
    private var topSplitController: UISplitViewController? {
        rootController as? UISplitViewController
    }
    private var topNavigationController: UINavigationController? {
        rootController as? UINavigationController
    }
    private var topTabBarController: UITabBarController? {
        rootController as? UITabBarController
    }
    private static func stringClassFromString(_ className: String) -> AnyClass! {
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!
        // return AnyClass!
        return cls
    }
}
