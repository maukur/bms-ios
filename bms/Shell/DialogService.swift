//
//  DialogService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import MBProgressHUD

class DialogService {
    
    private static let instance = DialogService()
    private init() {}
    static func initialize(getTopViewController: (() -> UIViewController?)? = nil) {
        self.instance.getTopViewController = getTopViewController
        SwiftEventBus.onMainThread(self, name: Consts.instance.dialogShowLoading) { result in
            DialogService.showLoading(result: result?.object)
        }
        SwiftEventBus.onMainThread(self, name: Consts.instance.dialogHideLoading) { _ in
            DialogService.hideLoading()
        }
        SwiftEventBus.onMainThread(self, name: Consts.instance.showAlert) { result in
            DialogService.showAlert(result: result?.object)
        }
        SwiftEventBus.onMainThread(self, name: Consts.instance.showActionSheet) { result in
            DialogService.showActionSheet(result: result?.object)
        }
    }
    static func showLoading(result: Any?) {
        MBProgressHUD.showAdded(to: (self.instance.getTopViewController!()?.view!)!, animated: true)
    }
    static func hideLoading() {
        MBProgressHUD.hide(for: (self.instance.getTopViewController!()?.view!)!, animated: true)
    }
    static func showAlert(result: Any?) {
        let dic = result as! Dictionary<String, Any?>
        let title = dic["title"] as! String?
        let message = dic["message"]  as! String?
        let action = dic["action"]  as! String?
        let completion = dic["completion"] as! ((Bool) -> Void)?
        let cancel = dic["cancelAction"] as! String?
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: action, style: .default, handler: { _ in completion?(true)})
        alert.addAction(okAction)
        if(cancel != nil) {
            let cancelAction  = UIAlertAction(title: cancel!, style: .cancel, handler: { _ in completion?(false)})
            alert.addAction(cancelAction)
        }
        self.instance.getTopViewController!()!.present(alert, animated: true)
    }
    static func showActionSheet(result: Any?) {
        let dic = result as! [String: Any]
        let title = dic["title"] as! String?
        let actions = dic["actions"]  as! [String]?
        let message = dic["message"]  as! String?
        let completion = dic["completion"] as! ((String?) -> Void)?
        let cancel = dic["cancelAction"] as! String?
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for item in actions! {
            let action  = UIAlertAction(title: item, style: .default, handler: { _ in completion?(item)})
            alert.addAction(action)
        }
        let cancelAction  = UIAlertAction(title: cancel!, style: .cancel, handler: { _ in completion?(nil)})
        alert.addAction(cancelAction)
        self.instance.getTopViewController!()!.present(alert, animated: true)
    }
    var getTopViewController: (() -> UIViewController?)?
}
