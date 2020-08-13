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
        
        self.baseViewModel?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.baseViewModel?.viewDidDisappear()
    }
}
