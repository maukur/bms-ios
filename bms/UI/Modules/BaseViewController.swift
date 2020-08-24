//
//  BaseNavigationController.swift
//  OrderKing
//
//  Created by Artem Tischenko on 08.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    private var baseViewModel : BaseViewModel? = nil
    var textFieldList: [UITextField] = []
    
    var dismissKeyboardAction: ((UITextField)  -> Void)?
    
    func getViewModel<T>() -> T{
          baseViewModel as! T
    }
    
     func setViewModel(viewModel:BaseViewModel){
        self.baseViewModel = viewModel
        self.bind()
     }
    
    func bind(){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.baseViewModel?.viewDidLoad()
    }
    
    
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        for field in textFieldList {
            guard field.isEditing else { continue }
            field.endEditing(true)
            dismissKeyboardAction?(field)
            
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.baseViewModel?.viewDidDisappear()
    }
    
}
