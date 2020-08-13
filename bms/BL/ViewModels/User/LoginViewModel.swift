//
//  LoginViewModel.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel
{
    func loginAction(login: String?, password: String?) {
        self.navigateTo(modules:["Expenses", "Calendar","Expenses"], mode: "tab")

        //DataServices.userDataService?.login(login: login!, password: password!, onCompleted: {
         //   result in
            
//            if(!result.isValid()){
//                let userInfo = result.data!
//                SettingsService.instance.token = userInfo.token
//
//            }
            
    //    })
    }
}
