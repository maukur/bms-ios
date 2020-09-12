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

    
    
   
    var dismissKeyboardAction: ((UITextField)  -> Void)?
    
    func getViewModel<T>() -> T{
        baseViewModel as! T
    }
    
    func setViewModel(viewModel:BaseViewModel){
        self.baseViewModel = viewModel
        self.bind()
    }
    var topView: UIView?
    
    func bind(){
        
        func getStateView(name:String) -> UIView {
            let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as! UIView
            return view
        }
        
        baseViewModel?.stateDidChange = {
            
            [weak self] state in
            guard let self = self else { return }
            
            self.topView?.removeFromSuperview()
            
            switch state {
                
            case "loading":
                let view = getStateView(name: "LoadingView")
                self.topView = view
                self.view.addSubview(view, stretchToFit:true)
                break;
            case "error":
                let view = getStateView(name: "ErrorView")
                self.topView = view
                self.view.addSubview(view, stretchToFit:true)
                break;
            case "empty":
                let view = getStateView(name: "EmptyView")
                self.topView = view
                self.view.addSubview(view, stretchToFit:true)
                break;
            default:
                self.topView = nil
                break
            }
            
 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseViewModel?.viewDidLoad()
        self.baseViewModel?.loadData()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.baseViewModel?.viewDidDisappear()
    }
    
    func retryAction() {
        baseViewModel?.loadData()
    }

}

