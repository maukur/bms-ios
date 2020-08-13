//
//  PhotoService.swift
//  bms
//
//  Created by Artem Tischenko on 07.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit


class ImagePickService: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private static let instance = ImagePickService()
    
    var imageDidSelect: ((UIImage?)-> Void)? = nil
    var getTopViewController: (() -> UIViewController?)? = nil
    
    
    static func initialize(getTopViewController: @escaping () -> UIViewController? ){
        self.instance.getTopViewController = getTopViewController
        SwiftEventBus.onMainThread(self, name: Consts.instance.getPhotoMessage) { result in ImagePickService.pickImage(result:result?.object) }
    }
    
    static func pickImage(result: Any?){
        let topVc = self.instance.getTopViewController!()
        let dic = result as! Dictionary<String, Any?>
        
        let completeFunc = dic["completedFunc"] as? (UIImage?) -> Void
        let sourceType = dic["sourceType"] as? UIImagePickerController.SourceType
        self.instance.imageDidSelect = completeFunc
        let vc = UIImagePickerController()
        vc.sourceType = sourceType!
        vc.allowsEditing = true
        vc.delegate = self.instance
        DispatchQueue.main.async {
            topVc!.present(vc, animated: true)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.global().async {
            self.imageDidSelect?(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        DispatchQueue.global().async {
            self.imageDidSelect?(selectedImage)
        }
        picker.dismiss(animated:true, completion: nil)
        
    }
    
}




