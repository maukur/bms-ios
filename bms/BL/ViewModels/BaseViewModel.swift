//
//  BaseViewModel.swift
//  OrderKing
//
//  Created by Artem Tischenko on 08.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    var navigationParams: Dictionary<String, Any> = [:]
    
    required init() {
        
    }
    
    func navigateTo(modules:[String], mode:String, masterModule: String = "", navigationParams:Dictionary<String,Any> = [:]){
          let dic = ["modules": modules, "masterModule": masterModule, "mode": mode, "navigationParams": navigationParams] as [String : Any]
        
        SwiftEventBus.postToMainThread(Consts.instance.NavigationToMessage, sender: dic)
    }
    
    func navigateBack(mode:String){
        let dic = ["mode": mode] as [String : Any]
        SwiftEventBus.postToMainThread(Consts.instance.NavigationBackMessage, sender: dic)
    }
    
    func showLoading(_ text: String = "", isBlocking:Bool = false){
        let dic = ["text": text, "isBlocking": isBlocking] as [String : Any]
        SwiftEventBus.postToMainThread(Consts.instance.dialogShowLoading, sender: dic)
    }
    func showAlert(title:String? = nil, message:String? = nil, action:String = "ok", cancelAnction: String? = nil, completion: ((Bool) -> Void)? = nil){
        let dic = [
            "title": title,
            "message" : message,
            "action" : action,
            "cancelAction" : cancelAnction,
            "completion" : completion
            ] as [String : Any?]
        SwiftEventBus.postToMainThread(Consts.instance.showAlert, sender: dic)
    }
    
    func showActionSheet(title:String? = nil, message:String? = nil, actions:[String] = [], cancelAnction: String? = "Cancel", completion: ((String?) -> Void)? = nil){
        let dic = [
            "title": title,
            "message" : message,
            "actions" : actions,
            "cancelAction" : cancelAnction,
            "completion" : completion
            ] as [String : Any?]
        SwiftEventBus.postToMainThread(Consts.instance.showActionSheet, sender: dic)
    }
    
    func hideLoading(){
        SwiftEventBus.postToMainThread(Consts.instance.dialogHideLoading)
    }
    
    func pickImage(sourceType:UIImagePickerController.SourceType) -> UIImage? {
        let semaphore = DispatchSemaphore(value: 0)
        var result: UIImage?
        let completedFunc: (UIImage?) -> Void =  {
            value in
            semaphore.signal()
            result = value
        }
        let dic = [
            "completedFunc": completedFunc,
            "sourceType": sourceType
            ] as [String : Any]
        SwiftEventBus.postToMainThread(Consts.instance.getPhotoMessage, sender: dic)
        semaphore.wait()
        return result
        
    }
    
    func viewDidLoad(){ }
    
    func viewDidDisappear(){ }
}
